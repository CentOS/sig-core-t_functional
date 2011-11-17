#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if SELinux is in enforcing mode"

if [ $SKIP_QA_HARNESS ]; then
    echo "Skipping this test ..."
else
    cat /selinux/enforce | grep 1  > /dev/null 2>&1
    t_CheckExitStatus $?
fi
