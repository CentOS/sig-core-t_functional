#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# MySQL
t_InstallPackage mysql-server
chkconfig mysqld on
service mysqld start
