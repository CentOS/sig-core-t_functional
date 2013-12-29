#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - adding imaptest local user account + attempting IMAP login"

{ userdel -rf imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest; } &>/dev/null

# creating maildir in HOME, else test will fail at first try
mkdir -m 700 -p /home/imaptest/mail/.imap/INBOX 
chown -R imaptest:imaptest /home/imaptest/mail

ret_val=1

t_Log "Dovecot IMAP login test"
# after a restart of dovecot this always results with
# 'imap-login: Disconnected (no auth attempts)' in /var/log/maillog
# first try will be ignored
echo -e "01 LOGIN imaptest imaptest\n" | nc -w 5 localhost 143 | grep -q "Logged in."

# and we need some time between login attempts
sleep 3

echo -e "01 LOGIN imaptest imaptest\n" | nc -w 5 localhost 143 | grep -q "Logged in."
# let's see if a third iteration reduces flakyness of the test
sleep 3

echo -e "01 LOGIN imaptest imaptest\n" | nc -w 5 localhost 143 | grep -q "Logged in."
ret_val=$?

if [ $ret_val != 0 ]
then
  tail /var/log/secure
  tail /var/log/maillog
fi
t_CheckExitStatus $ret_val

userdel -rf imaptest
