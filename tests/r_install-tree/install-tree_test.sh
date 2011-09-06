#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  check if the packages tree is installable."

yum -y install \* > /tmp/yum_install_tree.log 2>&1
ret_val=$?
# print the output of yum when it fails
[ $ret_val -ne 0 ] && tail /tmp/yum_install_tree.log

t_CheckExitStatus $ret_val
