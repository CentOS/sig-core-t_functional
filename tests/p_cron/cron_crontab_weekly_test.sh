#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - crontab test."

run-parts /etc/cron.weekly
tail /var/log/cron | grep -q 'run-parts(/etc/cron.weekly)'


t_CheckExitStatus $?
