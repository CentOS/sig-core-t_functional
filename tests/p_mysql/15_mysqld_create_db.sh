#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - MySQL create database test"

mysql -u root -e 'create database mysql_test' >/dev/null 2>&1
t_CheckExitStatus $?
