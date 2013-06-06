#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - installing and starting mysql server."

# MySQL
t_InstallPackage mysql-server
t_ServiceControl mysqld start >/dev/null 2>&1
