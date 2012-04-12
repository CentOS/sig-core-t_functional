#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Install tests deps
t_Log "Running $0 - httpd: installing curl, http, php and mysql"

t_InstallPackage curl

# HTTPD / PHP 
t_InstallPackage httpd mod_ssl php php-mysql 
chkconfig httpd on
t_ServiceControl httpd restart
