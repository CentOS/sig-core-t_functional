#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - MySQL GRANT privileges test"

mysql -u root -e 'create database mysql_test;'  > /dev/null 2>&1
mysql -u root -e "grant all on mysql_test.* to mysql_test@localhost identified by 'mysqltest'"  > /dev/null 2>&1
mysql -u root -e "flush privileges;" > /dev/null 2>&1
mysql -u mysql_test -pmysqltest mysql_test -e 'create table test_table(id int);' > /dev/null 2>&1
ret_val=$?

# Clean up
mysql -u root -e 'drop database mysql_test;'  > /dev/null 2>&1

t_CheckExitStatus $ret_val
