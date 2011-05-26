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
	t_Log "Attempting yum install: $*"
	/usr/bin/yum -y -d0 install "$@"
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

# Description: call this to process a list of folders containing test scripts
# Arguments: a list of folder paths to process (see example in runtests.sh)
function t_Process
{
	exec 7< $@
	
	while read -u 7 f
	do
		# skip files named readme or those that start with an _
		[[ "${f}" =~ readme|^_ ]] &&  continue;
		
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
# the dust settle. Failing to do this means tests that check for an
# open network port or response banner will probably fail for no 
# apparent reason.
function t_ServiceControl
{
	/sbin/service $1 $2

	# aaaand relax...
	sleep 3
}

export -f t_Log
export -f t_CheckExitStatus
export -f t_InstallPackage
export -f t_RemovePackage
export -f t_Process
export -f t_CheckDeps
export -f t_ServiceControl
