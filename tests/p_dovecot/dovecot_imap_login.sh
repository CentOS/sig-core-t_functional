#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - adding imaptest local user account + attempting IMAP login"

{ userdel -rf imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest; } &>/dev/null

# creating maildir in HOME, else test will fail at first try
mkdir -m 700 -p /home/imaptest/mail/.imap/INBOX 
chown -R imaptest:imaptest /home/imaptest/mail/.imap/INBOX

ret_val=1

t_Log "Dovecot IMAP login test"
echo -e "01 LOGIN imaptest imaptest\n" | nc localhost 143 | grep -q "Logged in."
ret_val=$?

if [ $ret_val == 1 ]
  then
  t_Log "Sometimes the first login fails (reason yet unknown to me)"
  t_Log "Trying a second time, as this seems to work, if not somethings really not working"
  echo -e "01 LOGIN imaptest imaptest\n" | nc localhost 143 | grep -q "Logged in."
  ret_val=$?
fi

t_CheckExitStatus $ret_val

userdel -rf imaptest
