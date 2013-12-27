#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - MySQL drop database test."

if [ $centos_ver -gt 6 ]
then
  t_Log 'mysql is only supported on C5 and C6, skipping'
  t_CheckExitStatus 0       
  exit 0
fi

mysql -u root -e 'drop database mysql_test' >/dev/null 2>&1
t_CheckExitStatus $?
