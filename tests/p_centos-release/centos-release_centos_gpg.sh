#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - $os_name RPM GPG Keys exist."

if [[ $is_almalinux == "yes" ]]; then
    file /etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux*  >/dev/null 2>&1
else
    file /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS*  >/dev/null 2>&1 && \
    file /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Security*  >/dev/null 2>&1
fi

t_CheckExitStatus $?
