#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

# FIXME: Test is very basic
echo -n "MySQL is listening test:  "
nc -w 1 localhost 3306  > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi

# kb: Can we do something like :
#     hn=$(mysql -N -B -u root -e "show variables like 'hostname'" | cut -f 2)
# then compare ${hn} to the real machine hostname ( `fqdn` ? ) to make sure
# they are identical 
