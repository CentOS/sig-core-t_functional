#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  check if auditd is running."

if [ "$SKIP_QA_HARNESS" -eq 1 ] | [ "$CONTAINERTEST" -eq 1 ] ; then
    echo "Skipping this test ..."
else
    service auditd status > /dev/null 2>&1
    t_CheckExitStatus $?
fi
