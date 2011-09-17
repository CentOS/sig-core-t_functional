#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - passwd file sanity check."

grep -q 'root:x:0' /etc/passwd && \
grep -q 'nobody:x:99' /etc/passwd


t_CheckExitStatus $?
