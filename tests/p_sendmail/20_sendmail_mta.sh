#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - sendmail can accept and deliver local email."
ret_val=1

# send mail to localhost
mail=$(echo -e "helo localhost\nmail from: root@localhost\nrcpt to: root@localhost\ndata\nt_functional test\n.\nquit\n" | nc -w 5 127.0.0.1 25 | grep accepted)
MTA_ACCEPT=$?
if [ $MTA_ACCEPT == 0 ]
  then
  t_Log 'Mail has been queued successfully'
fi

sleep 1

if [ "$centos_ver" -eq "8" ]; then
  t_Log "Dumping journalctl to /var/log/maillog"
  journalctl -u sendmail >> /var/log/maillog
fi
regex='250\ 2\.0\.0\ ([0-9A-Za-z]*)\ Message\ accepted\ for\ delivery'
if [[ $mail =~ $regex ]]
  then
  egrep -q "${BASH_REMATCH[1]}\:.*stat\=Sent" /var/log/maillog
  DELIVERED=$?
fi

if ([ $MTA_ACCEPT == 0  ] && [ $DELIVERED == 0 ])
  then
  ret_val=0
  t_Log 'Mail has been delivered and removed from queue.'
fi

t_CheckExitStatus $ret_val
