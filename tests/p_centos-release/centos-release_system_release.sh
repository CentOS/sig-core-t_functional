#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/centos-release has correct info test."

grep "CentOS" /etc/centos-release >/dev/null 2>&1

t_CheckExitStatus $?
