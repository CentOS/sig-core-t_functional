#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Yum configuration has the correct distroverpkg value test."

if (t_GetPkgRel basesystem | grep -q el6)
then
    grep "distroverpkg=centos-release" /etc/yum.conf >/dev/null 2>&1
else
    echo "Test skipped for CentOS <= 5"
fi

t_CheckExitStatus $?
