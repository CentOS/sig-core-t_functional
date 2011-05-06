#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo "Adding a new test user ..."
userdel pop3test; useradd pop3test && echo pop3test | passwd --stdin pop3test

echo -n "Dovecot POP3 login test:  "
echo -e "user pop3test\npass pop3test\n" | nc localhost 110 | grep "+OK Logged in." > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
