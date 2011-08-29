#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/centos-release compatibility symbolic links test."
if (t_GetPkgRel basesystem | grep -q el6)
then

grep "CentOS" /etc/centos-release >/dev/null 2>&1
(file /etc/redhat-release | grep "symbolic link to .centos-release."  >/dev/null 2>&1) &&\
(file /etc/system-release | grep "symbolic link to .centos-release."  >/dev/null 2>&1)

else
   echo "This test is not comptatible with CentOS <= 5"
fi

t_CheckExitStatus $?
