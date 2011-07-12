#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Yum configuration has the correct distroverpkg value test."

grep "distroverpkg=centos-release" /etc/yum.conf >/dev/null 2>&1

t_CheckExitStatus $?
