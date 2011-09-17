#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Check if networking is enabled."

grep -q 'NETWORKING=yes' /etc/sysconfig/network


t_CheckExitStatus $?
