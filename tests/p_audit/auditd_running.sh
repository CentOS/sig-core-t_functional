#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  check if auditd is running."

service auditd status > /dev/null 2>&1

t_CheckExitStatus $?
