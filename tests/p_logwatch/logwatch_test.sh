#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - logwatch test."

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

if [ "$centos_ver" -ge 7 ] ; then
 lw_options="--range Today"
else
 lw_options="--range Today --print"
fi

logwatch ${lw_options}| grep -q 'Logwatch End'

t_CheckExitStatus $?
