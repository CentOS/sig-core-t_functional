#!/bin/bash
# Author : Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

if  [ $# -eq 0 ]
then
  bridge=testbridge1
else
  bridge=$1
fi

t_Log "Running $0 - Adding a dummy Bridge: $bridge"
bridge_present=`brctl show | grep $bridge`
if ! [ "$bridge_present" ]
  then
  brctl addbr $bridge 
  bridge_present=`brctl show | grep $bridge`
  if [ "$bridge_present" ]
  then
    ret_val=0  
  else
    ret_val=1
  fi
else 
  ret_val=0
fi

t_CheckExitStatus $ret_val
