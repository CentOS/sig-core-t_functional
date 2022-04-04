#!/bin/bash
# Author: Rene Diepstraten <rene@renediepstraten.nl>

[ ${centos_ver} -lt 7 ] && exit
t_Log "Running $0 - checking if systemctl can check a service status"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

systemctl is-active auditd.service > /dev/null

t_CheckExitStatus $?