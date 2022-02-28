#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check if iptables kernel modules are loaded"

if [ "$centos_ver" = "7" ]|| [ "$centos_ver" = "8" ]|| [ "$centos_ver" = "9" ];then
 t_Log "CentOS $centos_ver uses firewalld and not iptables -> SKIP"
 t_CheckExitStatus 0
 exit 0
fi

lsmod | grep "ip_tables" > /dev/null 2>&1

t_CheckExitStatus $?

