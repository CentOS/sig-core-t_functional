#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - adding imaptest local user account + attempting IMAP login"

{ userdel imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest; } &>/dev/null

t_Log "Dovecot IMAP login test"
echo -e "01 LOGIN imaptest imaptest\n" | nc localhost 143 | grep "01 OK Logged in." > /dev/null 2>&1

t_CheckExitStatus $?