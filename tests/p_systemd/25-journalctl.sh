#!/bin/bash
# Author: Rene Diepstraten <rene@renediepstraten.nl>

[ ${centos_ver} -lt 7 ] && exit
t_Log "Running $0 - Testing journalctl for teststring"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

teststring=098f6bcd4621d373cade4e832627b4f6
timenow=$(date +'%T')
echo ${teststring} > /dev/kmsg
journalctl --since ${timenow} | grep -q ${teststring}

t_CheckExitStatus $?