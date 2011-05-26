#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# HTTPD / PHP 
t_InstallPackage httpd mod_ssl php php-mysql 
chkconfig httpd on
t_ServiceControl httpd start
