#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing if /usr/sbin/sendmail for postfix is sane."

mta=$(ls -H /usr/sbin/sendmail)

if [ $mta == '/usr/sbin/sendmail' ]
  then
  t_Log "link to sendmail seems to be sane"
  ret_val=0
else
  t_Log "link to sendmail seems to be wrong"
  ret_val=1
fi

t_CheckExitStatus $ret_val
