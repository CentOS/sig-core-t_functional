#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>
# Note: This was a known issue in CentOS 6.0
# See: http://bugs.centos.org/view.php?id=4993
# Christoph Galuschka: added functionality for C7

t_Log "Running $0 -  check that abrt is using CentOS' gpg keys."

if [ "$centos_ver" = "7" ] ;then
    ls /etc/pki/rpm-gpg/ | grep -q "RPM-GPG-KEY-CentOS"
elif [ "$centos_ver" = "6" ] ; then
    grep -q "RPM-GPG-KEY-CentOS" /etc/abrt/gpg_keys
else 
    echo "Skipped on CentOS 5"
fi

t_CheckExitStatus $?
