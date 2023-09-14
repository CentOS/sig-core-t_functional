#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - $os_name RPM GPG Keys exist."

file "/etc/pki/rpm-gpg/RPM-GPG-KEY-$os_name*"  >/dev/null 2>&1

t_CheckExitStatus $?
