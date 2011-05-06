#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

# FIXME: Test is very basic
echo -n "SSHD is listening test:  "
nc -w 1 localhost 22  > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
