#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - adding imaptest local user account + attempting IMAP login"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

{ userdel -rf imaptest; useradd imaptest && echo imaptest | passwd --stdin imaptest; } &>/dev/null

# creating maildir in HOME, else test will fail at first try
mkdir -m 700 -p /home/imaptest/mail/.imap/INBOX 
chown -R imaptest:imaptest /home/imaptest/mail

ret_val=1

t_Log "Dovecot IMAP login test"

# EL7 comes with nmap-nc , different from nc so different options to use

if [ "$centos_ver" -ge 7 ];then
 nc_options="-d 3 -w 5"
else
 nc_options="-i 3 -w 5"
fi

echo -e "01 LOGIN imaptest imaptest\n" | nc ${nc_options} localhost 143 | grep -q "Logged in."

ret_val=$?

if [ $ret_val != 0 ]
then
  tail /var/log/secure
  tail /var/log/maillog
fi
t_CheckExitStatus $ret_val

userdel -rf imaptest
