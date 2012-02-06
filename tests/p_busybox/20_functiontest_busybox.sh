#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - busybox functional tests: busybox provided functions are working."

busybox | grep -q 'ls,'
busy_ls=$?
if [ $busy_ls == 0 ]
  then
  t_Log "busybox provides 'ls'; testing it"
  touch /var/tmp/busybox
  busybox ls /var/tmp/ |grep -q busybox
  ls_working=$?
  if [ $ls_working == 1 ]
    then
    t_Log "busybox provides 'ls' but it does not seem to work"
  else
    t_Log "'ls' works"
  fi
  #cleaning up
  /bin/rm /var/tmp/busybox
fi
t_CheckExitStatus $ls_working

busybox | grep -q 'touch,'
busy_touch=$?
if [ $busy_touch == 0 ]
  then
  t_Log "busybox provides 'touch'; testing it"
  busybox touch /var/tmp/busybox
  ls /var/tmp/ |grep -q busybox
  touch_working=$?
  if [ $touch_working == 1 ]
    then
    t_Log "busybox provides 'touch' but it does not seem to work"
  else
    t_Log "'touch' works"
  fi
  #cleaning up
  /bin/rm /var/tmp/busybox
fi
t_CheckExitStatus $touch_working

