#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - busybox functional tests: busybox provided functions are working."


ret_val=0
busybox | grep -q 'ls,'
if [ $? == 0 ]
  then
  t_Log "busybox provides 'ls'; testing it"
  touch /var/tmp/busybox
  busybox ls /var/tmp/ |grep -q busybox
  if [ $? == 1 ]
    then
    t_Log "busybox provides 'ls' but it does not seem to work"
    ret_val=1
  else
    t_Log "'ls' works"
  fi
  #cleaning up
  /bin/rm /var/tmp/busybox
fi

busybox | grep -q 'touch,'
if [ $? == 0 ]
  then
  t_Log "busybox provides 'touch'; testing it"
  busybox touch /var/tmp/busybox
  ls /var/tmp/ |grep -q busybox
  if [ $? == 1 ]
    then
    t_Log "busybox provides 'touch' but it does not seem to work"
    ret_val=1
  else
    t_Log "'touch' works"
  fi
  #cleaning up
  /bin/rm /var/tmp/busybox
fi

t_CheckExitStatus $ret_val

