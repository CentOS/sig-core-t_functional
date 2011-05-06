#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo "Adding a new test user ..."
userdel imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest

echo -n "Dovecot IMAP login test:  "
echo -e "01 LOGIN imaptest imaptest\n" | nc localhost 143 | grep "01 OK Logged in." > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
