#!/bin/bash
# Author: Fabian Arrotin

t_Log "Running $0 -  install package selinux policycoreutils tools"
if [ "$centos_ver" = "6" ] ; then
  t_InstallPackage policycoreutils-python
elif [ "$centos_ver" -ge 8 ] ; then
  t_InstallPackage python3-libselinux
else
  t_InstallPackage libselinux-python
fi
