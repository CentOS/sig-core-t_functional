#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# MySQL
t_InstallPackage mysql-server
t_ServiceControl mysqld start >/dev/null 2>&1
