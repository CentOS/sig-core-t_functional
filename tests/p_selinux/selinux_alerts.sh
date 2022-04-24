#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check for SELinux alerts (AVC)"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

grep -v "AVC" /var/log/audit/audit.log > /dev/null 2>&1

t_CheckExitStatus $?

