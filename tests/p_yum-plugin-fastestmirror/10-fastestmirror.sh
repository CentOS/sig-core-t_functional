#!/bin/sh

# Ensure plugin is enabled :

t_Log "Running $0 - is y-p-fastestmirror enabled."
grep 'enabled=1' /etc/yum/pluginconf.d/fastestmirror.conf > /dev/null
t_CheckExitStatus $?

# timedhosts file ends up in different places on c5 and c6
if [ $centos_ver == 5 ]; then 
	$BaseDir=/var/cache/yum/
else
	$BaseDir=/var/cache/yum/`uanme -m`/$centos_ver
fi

t_Log "Running $0 - Ensure we have mirrorlist enabled."
egrep '^mirrorlist' /etc/yum.repos.d/*.repo > /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - is y-p-fastestmirror can get hosts + time them."
find $BaseDir -type f -name timedhosts.txt -exec rm -f {} \;
yum -d0 list kernel > /dev/null
hostsfound=$( wc -l ${BaseDir}/timedhosts.txt )
[ $hostsfound -gt 0 ]
t_CheckExitStatus $?

