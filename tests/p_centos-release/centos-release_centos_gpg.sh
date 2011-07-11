#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - CentOS RPM GPG Keys test."

file /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS*  >/dev/null 2>&1 && \
file /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Security*  >/dev/null 2>&1

t_CheckExitStatus $?
