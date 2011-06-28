#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Install tests deps
t_InstallPackage curl

# HTTPD / PHP 
t_InstallPackage httpd mod_ssl php php-mysql 
chkconfig httpd on
t_ServiceControl httpd start
