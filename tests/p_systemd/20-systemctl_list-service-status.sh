#!/bin/bash
# Author: Rene Diepstraten <rene@renediepstraten.nl>

[ ${centos_ver} -lt 7 ] && exit
t_Log "Running $0 - checking if systemctl can check a service status"

systemctl is-active auditd.service > /dev/null

t_CheckExitStatus $?