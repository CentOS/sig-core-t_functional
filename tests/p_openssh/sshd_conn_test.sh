#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

# FIXME: Test is very basic

t_Log "Running $0 - SSHD is listening test."

nc -w 1 localhost 22  > /dev/null 2>&1

t_CheckExitStatus $?
