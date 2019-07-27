#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - passwd file sanity check."

if [ "$centos_ver" -eq "8" ] ;then
  nobody_grpid="65534"
else
  nobody_grpid="99"
fi

grep -q 'root:x:0' /etc/passwd && \
grep -q "nobody:x:${nobody_grpid}" /etc/passwd


t_CheckExitStatus $?
