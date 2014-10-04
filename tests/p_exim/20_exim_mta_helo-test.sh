#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - exim can accept and deliver local email."

if [ $centos_ver == '5' ]
  ret_val=1

  # send mail to localhost
  mail=$(echo -e "helo localhost\nmail from: root@localhost\nrcpt to: root@localhost\ndata\nt_functional test\n.\nquit\n" | nc -w 5 localhost 25 | grep "250 OK")
  MTA_ACCEPT=$?
  if [ $MTA_ACCEPT == 0 ]
    then
    t_Log 'Mail has been queued successfully'
  fi

250 OK id=1XaR7Q-0005D8-Cm

  regex='250\ OK\ id\=([0-9A-Za-z-]*)'
  if [[ $mail =~ $regex ]]
    then
    grep -q "${BASH_REMATCH[1]}: removed" /var/log/exim/main.log
    DELIVERED=$?
  fi

  if ([ $MTA_ACCEPT == 0  ] && [ $SPOOLFILE == 0 ])
    then
    ret_val=0
  fi
else
  t_Log t_Log "This is not a C5 system - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
