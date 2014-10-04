#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - exim can accept and deliver local email."

if [ $centos_ver == '5' ]
  then
  ret_val=1

  # send mail to localhost
  mail=$(./tests/p_exim/_helper_exim_ehlo.expect | grep "250 OK")
  MTA_ACCEPT=$?
  if [ $MTA_ACCEPT == 0 ]
    then
    t_Log 'Mail has been queued successfully'
  fi

  regex='250\ OK\ id\=([0-9A-Za-z-]*)'
  if [[ $mail =~ $regex ]]
    then
    sleep 1
    grep -q "${BASH_REMATCH[1]} Completed" /var/log/exim/main.log
    DELIVERED=$?
  fi

  if ([ $MTA_ACCEPT == 0  ] && [ $DELIVERED == 0 ])
    then
    ret_val=0
  fi

  # delete user for local delivery
  userdel eximtest

else
  t_Log "This is not a C5 system - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
