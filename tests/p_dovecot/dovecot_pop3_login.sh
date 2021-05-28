#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - adding pop3test local user account + attempting POP3 login"

{ userdel -rf pop3test; useradd pop3test && echo pop3test | passwd --stdin pop3test; } &>/dev/null

# creating maildir in HOME, else test will fail at first try
mkdir -m 700 -p /home/pop3test/mail/.imap/INBOX
chown -R pop3test:pop3test /home/pop3test/mail/.imap/INBOX

t_Log "Dovecot POP3 login test"

echo -e "user pop3test\npass pop3test\n" | nc -w 5 localhost 110 | grep -q "+OK Logged in."

t_CheckExitStatus $?

userdel -rf pop3test
