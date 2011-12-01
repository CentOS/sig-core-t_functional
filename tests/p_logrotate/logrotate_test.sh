#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - logrotate: is happy with all configs"

/usr/sbin/logrotate /etc/logrotate.conf

t_CheckExitStatus $?
