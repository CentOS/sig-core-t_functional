#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install LAMP stack."

# MySQL
# starting with 5.10, we have to differ between mysql55 and mysql
if [ $centos_ver = 5 ]
then
  t_InstallPackage mysql55-mysql-server httpd php
else
  t_InstallPackage mysql-server httpd php
fi

t_ServiceControl httpd stop
ps ax | grep -v grep | grep -q httpd
if [ $? = 0 ]
then
  t_Log "httpd still running - killing"
  killall -9 httpd
fi
sleep 1
t_ServiceControl httpd start
