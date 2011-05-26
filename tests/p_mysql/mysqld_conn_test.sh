#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - mysqld listening test."

# FIXME: Test is very basic
nc -d -w 1 localhost 3306 >/dev/null 2>&1

t_CheckExitStatus $?

# kb: Can we do something like :
#     hn=$(mysql -N -B -u root -e "show variables like 'hostname'" | cut -f 2)
# then compare ${hn} to the real machine hostname ( `fqdn` ? ) to make sure
# they are identical 
