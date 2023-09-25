#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/$vendor-release has correct branding"

if [ "$centos_ver" = "5" ] ; then
    grep "CentOS" /etc/redhat-release >/dev/null 2>&1
else
    grep $os_name /etc/$vendor-release >/dev/null 2>&1
fi

t_CheckExitStatus $?

