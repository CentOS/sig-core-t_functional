#!/bin/sh

# Ensure plugin is enabled :

if [ "$centos_ver" -ge "8" ] ; then
 t_Log "yum is replaced by dnf on el8. SKIP"
 exit 0
fi


isAltArch=$(uname -m|egrep -q 'armv7l|aarch64|ppc64|ppc64le'|| echo 1 && echo 0)

if [ "$isAltArch" = "0" ] && [ $centos_ver -lt 7 ] ; then
 t_Log "Skipping for altarch, using only mirror.centos.org"
 t_Log "SKIP"
 exit 0
fi

t_Log "Running $0 - is y-p-fastestmirror enabled."
grep 'enabled=1' /etc/yum/pluginconf.d/fastestmirror.conf > /dev/null
t_CheckExitStatus $?

# timedhosts file ends up in different places on c5 and c6
if [ $centos_ver == 5 ]; then 
	BaseDir=/var/cache/yum/
else
	BaseArch=`uname -i`
	if [ "$BaseArch" == "armv7l" ];then
		BaseArch="armhfp"
	fi
	BaseDir=/var/cache/yum/$BaseArch/$centos_ver
fi

t_Log "Running $0 - Ensure we have mirrorlist enabled."
egrep '^mirrorlist' /etc/yum.repos.d/*.repo > /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - y-p-fastestmirror can get hosts from mirrorlist"
find $BaseDir -type f -name timedhosts.txt -exec rm -f {} \;
yum -d0 list kernel > /dev/null

hostsfound=`cat $BaseDir/timedhosts.txt | wc -l` > /dev/null

# we need to make sure the file was recreated
if [ -f ${BaseDir}/timedhosts.txt ]; then 
	if [ $hostsfound -lt 1 ]; then
		retval=1
	else
		retval=0
	fi
else
	retval=1
fi
t_CheckExitStatus $retval

t_Log "Running $0 - number of hosts y-p-fastestmirror can get: $( wc -l ${BaseDir}/timedhosts.txt )"
