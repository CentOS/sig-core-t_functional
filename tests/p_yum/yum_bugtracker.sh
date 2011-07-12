#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Yum is using CentOS' bugtracker test."

grep "http://bugs.centos.org" /etc/yum.conf >/dev/null 2>&1

t_CheckExitStatus $?
