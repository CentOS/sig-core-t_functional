#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - initscripts CentOS branding "

if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log "Test not required for CentOS 6.x"
   exit 0
else
    grep "CentOS" /etc/rc.sysinit > /dev/null 2>&1
fi

t_CheckExitStatus $?
