#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if chkconfig can list a service status"

# auditd is used as example because it's standard with minimal install
chkconfig --list auditd | grep -q '3:on'

t_CheckExitStatus $?

