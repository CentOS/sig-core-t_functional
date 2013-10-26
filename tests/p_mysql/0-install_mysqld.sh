#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - installing and starting mysql server."

# MySQL
# starting with 5.10, we have to differ between mysql55 and mysql
if [ $centos_ver = 5 ]
then
  t_InstallPackage mysql55-mysql-server nc
  t_ServiceControl mysql55-mysqld start >/dev/null 2>&1
else
  t_InstallPackage mysql-server nc
  t_ServiceControl mysqld start >/dev/null 2>&1
fi
