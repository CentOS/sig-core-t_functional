#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - group file sanity check."

grep -q 'root:x:0' /etc/group && \
grep -q 'bin:x:1' /etc/group && \
grep -q 'daemon:x:2' /etc/group && \
grep -q 'nobody:x:99' /etc/group 


t_CheckExitStatus $?
