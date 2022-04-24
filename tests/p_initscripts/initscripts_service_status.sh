#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - check if service cmd can get service status"

# auditd is used as example because it's standard with minimal install
service auditd status 

t_CheckExitStatus $?

