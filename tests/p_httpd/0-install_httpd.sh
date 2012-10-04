#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka

# Install tests deps
t_Log "Running $0 - httpd: installing curl, http, php and mysql"

t_InstallPackage curl

# HTTPD / PHP 
t_InstallPackage httpd mod_ssl php php-mysql 
t_ServiceControl httpd stop
sleep 3
killall httpd
sleep 3
t_ServiceControl httpd start

