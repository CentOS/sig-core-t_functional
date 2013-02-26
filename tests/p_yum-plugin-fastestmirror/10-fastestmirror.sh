#!/bin/sh

# Ensure plugin is enabled :

t_Log "Running $0 - is y-p-fastestmirror enabled."
grep 'enabled=1' /etc/yum/pluginconf.d/fastestmirror.conf > /dev/null
t_CheckExitStatus $?

# timedhosts file ends up in different places on c5 and c6
if [ $centos_ver == 5 ]; then 
	BaseDir=/var/cache/yum/
else
	BaseDir=/var/cache/yum/`uname -i`/$centos_ver
fi

t_Log "Running $0 - Ensure we have mirrorlist enabled."
egrep '^mirrorlist' /etc/yum.repos.d/*.repo > /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - is y-p-fastestmirror can get hosts"
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

t_Log "Running $0 - is y-p-fastestmirror can get"

hostsfound=$( wc -l ${BaseDir}/timedhosts.txt )

