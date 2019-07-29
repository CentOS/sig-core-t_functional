#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Ref.: http://bugs.centos.org/view.php?id=4943

if [ "$centos_ver" -ge 8 ] ; then
  exit 0
fi
t_Log "Running $0 - NTP is using CentOS server pool test."

grep ".centos.pool.ntp.org" /etc/ntp.conf > /dev/null 2>&1

t_CheckExitStatus $?
