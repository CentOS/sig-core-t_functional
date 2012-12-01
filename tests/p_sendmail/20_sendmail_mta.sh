#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - sendmail can accept and deliver local email."

MAILSPOOL=/var/spool/mail/root

# make shure spool file is empty
cat /dev/null > $MAILSPOOL
ret_val=1

# send mail to localhost
echo -e "helo localhost\nmail from: root@localhost\nrcpt to: root@localhost\ndata\nt_functional test\n.\nquit\n" | nc -w 5 localhost 25 | grep -q "250 2.0.0"
if [ $? = 0 ]
  then
  t_Log 'Mail has been queued successfully'
  MTA_ACCEPT=0
fi

sleep 1
grep -q 't_functional test' $MAILSPOOL
if [ $? = 0 ]
  then
  t_Log 'previously sent mail is in '$MAILSPOOL
  SPOOLFILE=0
fi

if ([ $MTA_ACCEPT = 0  ] && [ $SPOOLFILE = 0 ])
  then
  ret_val=0
fi

t_CheckExitStatus $ret_val

