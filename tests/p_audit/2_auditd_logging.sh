#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  check if audit log is not empty."

[[ -s /var/log/audit/audit.log ]] 

t_CheckExitStatus $?
