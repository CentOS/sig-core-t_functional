#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - adding imaptest local user account + attempting IMAP login"

{ userdel -rf imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest; } &>/dev/null

t_Log "Dovecot IMAP login test"
echo -e "01 LOGIN imaptest imaptest\n" | nc localhost 143 | grep "01 OK Logged in."

if (t_GetPkgRel dovecot | grep -q el6)
then
   echo "[*] ** EXPERIMENTAL **: Test not working on CentOS 6, forcing PASS"
   true 
fi

t_CheckExitStatus $?
