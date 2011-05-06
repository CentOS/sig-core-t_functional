#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo -n "vsFTPd anonymous can login test:  "
echo -e "user anonymous\npass password\nquit" | nc localhost 21 | grep "230 Login successful." > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
