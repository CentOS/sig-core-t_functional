#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - crontab test."

run-parts /etc/cron.daily
tail /var/log/cron | grep -q 'run-parts(/etc/cron.daily)'


t_CheckExitStatus $?
