#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# NOTE: squirrelmail rpm has require: httpd php php-mbstring
# Squirellmail has been removed from el6

t_Log "Running $0 - install squirrelmail"
if [ "$centos_ver" -gt "5" ] ;then
  t_Log "It seems to be a CentOS $centos_ver system, this test will be disabled -> SKIP"
  exit 0
else
   t_InstallPackage squirrelmail 
   t_ServiceControl httpd restart
fi
