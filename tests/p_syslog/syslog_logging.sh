#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if syslog deamon is working"

logger "t_functional_logging_test"

sleep 2

if [ "$centos_ver" -ge 8 ]; then
  t_Log "Dumping journalctl to /var/log/maillog"
  journalctl >> /var/log/messages
fi

grep "t_functional_logging_test" /var/log/messages > /dev/null 2>&1

t_CheckExitStatus $?

