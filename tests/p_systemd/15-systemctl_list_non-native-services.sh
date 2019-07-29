#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Rene Diepstraten <rene@renediepstraten.nl>

[ ${centos_ver} -lt 7 ] && exit
t_Log "Running $0 - Checking if systemctl can check if a non-native service is enabled"

systemctl is-enabled kdump.service 2> /dev/null | grep -q -E 'enabled|disabled'

t_CheckExitStatus $?
