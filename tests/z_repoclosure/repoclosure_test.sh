#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  repoclosure test ."

if [ "$centos_ver" -ge 8 ] ; then
    t_Log "Skip this test in versions greater than 8, because repoclosure doesn't work with modules enabled"
else

    t_InstallPackage yum-utils

    t_Log "Running repoclosure test ..."

    repoclosure > /tmp/repoclosure.log 2>&1
    grep -q 'unresolved deps' /tmp/repoclosure.log
    if [ $? -eq 0 ] ; then
        ret_val=1
    else
        ret_val=0
    fi

    # print the output of repoclosure when it fails
    [ $ret_val -eq 1 ] && cat /tmp/repoclosure.log

    t_CheckExitStatus $ret_val
fi
