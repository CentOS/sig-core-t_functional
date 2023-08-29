#!/bin/bash


# Description: call this function whenever you need to log output (preferred to calling echo)
# Arguments: log string to display
function t_Log
{
	printf "[+] `date` -> $*\n"
}

# Description: call this at the end of your script to assess the exit status
# Arguments: the exit status from whatever you want checked (ie, '$?')
function t_CheckExitStatus
{
	[ $1 -eq 0 ] && { t_Log "PASS"; return $PASS; }

	t_Log "FAIL"
	exit $FAIL
}

# Description: call this to perform yum-based installs of packages
# Arguments: a space separated list of package names to install.
function t_InstallPackage
{
    if [ "$centos_ver" -ge "8" ]; then
        mkdir /var/cache/{dnf,yum,system-upgrade}
        dnf makecache
    fi
	t_Log "Attempting yum install: $*"
	/usr/bin/yum -y -d${YUMDEBUG} install "$@"
  # TODO: add a hook here, to make sure all binary files have ldd run
  # against them, and that there are no missing linker targets
	t_CheckExitStatus $?
}

# Description: call this to install packages without weak dependencies
# Arguments: a space separated list of package names to install
function t_InstallPackageMinimal
{
    t_Log "Installing packages: $@"
    dnf --assumeyes --debuglevel ${YUMDEBUG} --setopt install_weak_deps=0 install $@
    t_CheckExitStatus $?
}

# Description: call this to perform a yum-based removal of packages
# Arguments: a space separated list of package names to remove.
function t_RemovePackage
{
	t_Log "Attempting yum remove: $*"
	/usr/bin/yum -y -d0 remove "$@"
	t_CheckExitStatus $?
}

# Description: call this to enable a module stream
# Arguments: the module:stream(s) to enable
function t_EnableModuleStream
{
    t_Log "Enabling module stream $@"
    dnf --assumeyes --debuglevel ${YUMDEBUG} module enable $@
    t_CheckExitStatus $?
}

# Description: call this to reset a module
# Arguments: the module(s) to reset
function t_ResetModule
{
    t_Log "Resetting module $@"
    dnf --assumeyes --debuglevel ${YUMDEBUG} module reset $@
    t_CheckExitStatus $?
}

# Description: call this to process a list of folders containing test scripts
# Arguments: a file handle from which to read the names of paths to process.
function t_Process
{
	exec 7< $@

	while read -u 7 f
	do
		# skip files named readme or those that start with an _
		[[ "$(basename ${f})" =~ readme|^_ ]] &&  continue;

		# handy tip: chmod -x to disable individual test scripts.
		[ -x ${f} ] && ${f}

	done

	return 0
}

# Description: check to see if one or more packages are installed
# return true if they're all installed, false if not.
# Arguments: one or more package names to check for.
function t_CheckDeps
{
	# TODO

	# success, all packages are installed
	return 0
}

# Description: perform a service control and sleep for a few seconds to let
#   the dust settle. Using this function avoids a race condition wherein
#   subsequent tests execute (and typically fail) before a service has had a
#   chance to fully start/open a network port etc.
# Call it with cycle instead of start, and it will stop+start
#   handy, if you dont know the service might already be running
function t_ServiceControl
{
  if [ $2 = "cycle" ]; then
    /sbin/service $1 stop > /dev/null 2>&1
    sleep 3
    /sbin/service $1 start
  else
  	/sbin/service $1 $2
  fi

	# aaaand relax...
	sleep 3
}

# Description: Get a package (rpm) release number
function t_GetPkgRel
{
       rpm -q --queryformat '%{RELEASE}' $1
}

# Description: return the distro release (returns 5 or 6 now)
function t_DistCheck
{
	rpm -q $(rpm -qf /etc/redhat-release) --queryformat '%{version}\n'|cut -f 1 -d '.'
}
# Additionally set distro release to $centos_ver
centos_ver=$(t_DistCheck)

# Description: test if we are using CentOS Stream
function t_StreamCheck
{
    rpm -q centos-stream-release &> /dev/null && echo "yes" || echo "no"
}
# set stream variable
centos_stream=$(t_StreamCheck)

function t_AlmaLinuxCheck
{
    rpm -q almalinux-release &> /dev/null && echo "yes" || echo "no"
}
is_almalinux=$(t_AlmaLinuxCheck)

function t_GetMinorVer
{
    rpm -q $(rpm -qf /etc/redhat-release) --queryformat '%{version}\n'|cut -f 2 -d '.'
}

if [[ $is_almalinux == "yes" ]]; then
    minor_ver=$(t_GetMinorVer)
fi
# Description: skip test on a particular release
# Arguments: release, reason
function t_SkipRelease {
    if [ $(rpm --eval %rhel) -eq $1 ]; then
        t_Log "$2"
        t_Log "SKIP"
        exit 0
    fi
}

# Description: skip test on everything except a particular release
# Arguments: release, reason
function t_SkipNotRelease {
    if [ $(rpm --eval %rhel) -ne $1 ]; then
        t_Log "$2"
        t_Log "SKIP"
        exit 0
    fi
}

# Description: skip test on releases less than a particular release
# Arguments: release, reason
function t_SkipReleaseLessThan {
    if [ $(rpm --eval %rhel) -lt $1 ]; then
        t_Log "$2"
        t_Log "SKIP"
	exit 0
    fi
}

# Description: skip test on releases greater than a particular release
# Arguments: release, reason
function t_SkipReleaseGreaterThan {
    if [ $(rpm --eval %rhel) -gt $1 ]; then
        t_Log "$2"
        t_Log "SKIP"
        exit 0
    fi
}

# Description: Get a package (rpm) version number
function t_GetPkgVer
{
       rpm -q --queryformat '%{version}' $1
}

# Description: get the arch
function t_GetArch
{
	rpm -q kernel --queryformat '%{arch}\n' | head -n 1
}

# Set the arch
arch=$(t_GetArch)

function t_CheckForPort
{
        while true
        do
        sleep 1
          >/dev/null 2>&1 >/dev/tcp/localhost/$1
        if [ "$?" = "0" ] ; then
          t_Log "Waiting for tcp port $1 to be listening ..."
          break
        fi
        done

}

function t_Assert
{
 $@ >/dev/null 2>&1
 t_CheckExitStatus $?
}

function t_Assert_Equals
{
 [ $1 -eq $2 ]
 t_CheckExitStatus $?
}

function t_Select_Alternative
{
	name=$1
	search=$2
	option=$(/bin/echo|/usr/sbin/alternatives --config "$name"|/bin/grep -E "$search"|/usr/bin/head -n1|sed 's/    .*//g;s/[^0-9]//g')
	if [ -z "$option" ];then
		t_Log "Option not found for altenative $search of $name"
		t_CheckExitStatus 1
	fi
	t_Log "Selecing alternative $option for $name--$search"
	/bin/echo "$option"|/usr/sbin/alternatives --config "$name" >/dev/null 2>&1
}

vendor="centos"
os_name="CentOS"

if [[ $is_almalinux == "yes" ]]; then
    export minor_ver
    vendor="almalinux"
    os_name="AlmaLinux"
fi

export -f t_Log
export -f t_CheckExitStatus
export -f t_InstallPackage
export -f t_InstallPackageMinimal
export -f t_RemovePackage
export -f t_EnableModuleStream
export -f t_ResetModule
export -f t_Process
export -f t_CheckDeps
export -f t_ServiceControl
export -f t_SkipRelease
export -f t_SkipNotRelease
export -f t_SkipReleaseLessThan
export -f t_SkipReleaseGreaterThan
export -f t_GetPkgRel
export -f t_DistCheck
export -f t_GetPkgVer
export -f t_GetArch
export -f t_CheckForPort
export -f t_Assert
export -f t_Assert_Equals
export -f t_Select_Alternative
export centos_ver
export centos_stream
export arch
export is_almalinux
export vendor
export os_name

if [ -z "$CONTAINERTEST" ]; then
    export CONTAINERTEST=0
fi
