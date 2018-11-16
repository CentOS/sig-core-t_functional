#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

php_mysql="php-mysql"
if [ $centos_ver -ge 7 ]
then
  php_mysql="php-mysqlnd"
fi

# Install tests deps
t_Log "Running $0 - httpd: installing curl, http, php and $php_mysql"

#t_InstallPackage curl

# HTTPD / PHP 
t_InstallPackage curl httpd mod_ssl php $php_mysql
t_ServiceControl httpd stop
sleep 3
killall httpd
sleep 3
t_ServiceControl httpd start

