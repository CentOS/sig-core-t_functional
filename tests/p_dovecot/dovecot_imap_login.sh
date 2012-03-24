#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - adding imaptest local user account + attempting IMAP login"

{ userdel -rf imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest; } &>/dev/null

# creating maildir in HOME, else test will fail at first try
mkdir -m 700 -p /home/imaptest/mail/.imap/INBOX 
chown -R imaptest:imaptest /home/imaptest/mail/.imap/INBOX

t_Log "Dovecot IMAP login test"
echo -e "01 LOGIN imaptest imaptest\n" | nc localhost 143 | grep -q "Logged in."

t_CheckExitStatus $?

userdel -rf imaptest
