#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - attempting to install webalizer"

if [ "$centos_ver" = "7" ] ; then
 t_Log "No webalizer package for CentOS $centos_ver -> SKIP"
 t_CheckExitStatus 0
 exit 0
fi

t_InstallPackage webalizer 
t_InstallPackage httpd
t_ServiceControl httpd stop
ps ax | grep -v grep | grep -q httpd
if [ $? = 0 ]
then
  t_Log "httpd still running - killing"
  killall -9 httpd
fi
sleep 1
t_ServiceControl httpd start

