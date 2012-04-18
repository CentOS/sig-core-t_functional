#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if service cmd can get service status"

# auditd is used as example because it's standard with minimal install
service auditd status | grep -q 'is running'

t_CheckExitStatus $?

