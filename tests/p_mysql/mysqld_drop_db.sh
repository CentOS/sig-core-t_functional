#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo -n "MySQL drop database test:  "
mysql -u root -e 'drop database mysql_test'  > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
