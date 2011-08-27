#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check for SELinux alerts (AVC)"

grep "AVC" /var/log/audit/audit.log > /dev/null 2>&1

t_CheckExitStatus $?

