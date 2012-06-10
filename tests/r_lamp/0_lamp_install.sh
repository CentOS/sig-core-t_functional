#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install LAMP stack."

t_InstallPackage httpd mysql-server php
t_ServiceControl httpd stop
ps ax | grep -v grep | grep -q httpd
if [ $? = 0 ]
then
  t_Log "httpd still running - killing"
  killall -9 httpd
fi
sleep 1
t_ServiceControl httpd start
