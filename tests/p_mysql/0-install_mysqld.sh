#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - installing and starting mysql server."

# MySQL
# starting with 5.10, we have to add mysql55

if [ "$centos_ver" = "7" ] ; then
  my_packages="mariadb mariadb-server nc"
  mysql_service="mariadb"
elif [ "$centos_ver" = "5" ] ;then
  my_packages="mysql mysql-server nc mysql55-mysql-server"
  mysql_service="mysqld"
else
  my_packages="mysql mysql-server nc"
  mysql_service="mysqld"
fi

t_InstallPackage ${my_packages}

t_ServiceControl ${mysql_service} start >/dev/null 2>&1
