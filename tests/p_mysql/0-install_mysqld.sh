#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - installing and starting mysql server."

# MySQL
# starting with 5.10, we have to add mysql55
if [ $centos_ver = 5 ]
then
  t_InstallPackage mysql55-mysql-server mysql-server nc
else
  t_InstallPackage mysql-server nc
fi
t_ServiceControl mysqld start
