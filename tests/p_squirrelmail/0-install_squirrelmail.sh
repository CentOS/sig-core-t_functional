#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# NOTE: squirrelmail rpm has require: httpd php php-mbstring
# Squirellmail has been removed from el6

if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log It seems to be a CentOS 6.x system, this test will be disabled
   exit 0
else
   t_InstallPackage squirrelmail 
   t_ServiceControl httpd restart
fi
