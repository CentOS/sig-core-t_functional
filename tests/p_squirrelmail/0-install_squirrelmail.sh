#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# NOTE: squirrelmail rpm has require: httpd php php-mbstring
t_InstallPackage squirrelmail 
t_ServiceControl httpd reload
