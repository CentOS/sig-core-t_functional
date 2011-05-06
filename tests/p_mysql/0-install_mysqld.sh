#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# MySQL
yum -y install mysql-server
chkconfig mysqld on
service mysqld start
