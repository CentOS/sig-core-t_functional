#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  check CentOS' Kernel Module GPG key."

grep 'User ID: CentOS (Kernel Module GPG key)' /var/log/dmesg > /dev/null 2>&1

t_CheckExitStatus $?
