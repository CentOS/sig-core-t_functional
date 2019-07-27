#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - group file sanity check."

if [ "$centos_ver" -eq "8" ] ;then
  nobody_grpid="65534"
else
  nobody_grpid="99"
fi

grep -q 'root:x:0' /etc/group && \
grep -q 'bin:x:1' /etc/group && \
grep -q 'daemon:x:2' /etc/group && \
grep -q "nobody:x:${nobody_grpid}" /etc/group 


t_CheckExitStatus $?
