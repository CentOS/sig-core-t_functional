#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/centos-release has correct info test."
if (t_GetPkgRel basesystem | grep -q el6)
then
    grep "CentOS" /etc/centos-release >/dev/null 2>&1
else
    grep "CentOS" /etc/redhat-release >/dev/null 2>&1
fi
t_CheckExitStatus $?
