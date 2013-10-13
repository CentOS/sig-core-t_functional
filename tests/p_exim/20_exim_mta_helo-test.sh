#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - exim can accept and deliver local email."

if [ $centos_ver == '5' ]
  then
  MAILSPOOL=/var/spool/exim/input/

  # make shure spool dir is empty
  rm -rf $MAILSPOOL*
  ret_val=1

  # send mail to localhost
  ./tests/p_exim/_helper_exim_helo.expect | grep -q "250 OK"
  if [ $? = 0 ]
    then
    t_Log 'Mail has been queued successfully'
    MTA_ACCEPT=0
  fi

  sleep 5
  grep -q 't_functional test' $MAILSPOOL*
  if [ $? = 0 ]
    then
    t_Log 'previously sent mail is in '$MAILSPOOL'*'
    SPOOLFILE=0
  fi

  if ([ $MTA_ACCEPT = 0  ] && [ $SPOOLFILE = 0 ])
    then
    ret_val=0
  fi
else
  t_Log t_Log "This is not a C5 system - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
