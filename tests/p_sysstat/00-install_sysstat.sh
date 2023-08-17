#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# SysStat Performance Monitoring Tools for Linux
t_InstallPackage sysstat

if [ "$centos_ver" -lt 8 ] ; then
  t_InstallPackage psmisc
fi


