#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if iptables kernel modules are loaded"

lsmod | grep "ip_tables" > /dev/null 2>&1

t_CheckExitStatus $?

