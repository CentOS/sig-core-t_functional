#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Note: This was a known issue in CentOS 6.0
# See: http://bugs.centos.org/view.php?id=4993

t_Log "Running $0 -  check that abrt is using CentOS' gpg keys."

if (t_GetPkgRel basesystem | grep -q el6)
then
    grep -q "RPM-GPG-KEY-CentOS" /etc/abrt/gpg_keys
else 
    echo "Skipped on CentOS 5"
fi

t_CheckExitStatus $?
