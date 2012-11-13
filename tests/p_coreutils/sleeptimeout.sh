#!/bin/bash
# Author Alice Kaerast <alice@kaerast.info>

t_Log "$0 checking timeout and sleep"

if [ $centos_ver = 5 ]
  then
  t_Log "This is a C5 system. no 'timeout' available. Skipping." 
  ret_val=0
else
  timeout 1 sleep 2
  test $? -eq 124 && timeout 2 sleep 1
  ret_val=$?
fi

t_CheckExitStatus $ret_val
