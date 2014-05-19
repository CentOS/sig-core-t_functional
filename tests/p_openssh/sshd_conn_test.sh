#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

# FIXME: Test is very basic

t_Log "Running $0 - SSHD is listening test."

>/dev/null 2>&1 >/dev/tcp/localhost/22

t_CheckExitStatus $?
