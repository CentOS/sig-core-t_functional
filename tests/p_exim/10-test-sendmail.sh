#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing if /usr/sbin/sendmail for exim is sane."

if (t_GetPkgRel basesystem | grep -q el5)
then
  mta=$(ls -H /usr/sbin/sendmail)

  if [ $mta == '/usr/sbin/sendmail' ]
    then
    t_Log "link to sendmail seems to be sane"
    ret_val=0
  else
    t_Log "link to sendmail seems to be wrong"
    ret_val=1
  fi
else
  t_Log "This seems to be a C6 system - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
