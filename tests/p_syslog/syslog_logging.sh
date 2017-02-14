#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if syslog deamon is working"

logger "t_functional_logging_test"

sleep 2

grep "t_functional_logging_test" /var/log/messages > /dev/null 2>&1

t_CheckExitStatus $?

