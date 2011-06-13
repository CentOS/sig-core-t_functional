#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Squid test."

squidclient -T 2 http://www.centos.org/ | grep "CentOS"  >/dev/null 2>&1

t_CheckExitStatus $?
