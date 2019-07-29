#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

if [ "$centos_ver" -ge 8 ] ; then
  t_Log "no ntp in CentOS $centos_ver ... SKIP"
  exit 0
fi
# NTPd
t_InstallPackage ntp
