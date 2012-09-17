#!/bin/bash
# Author : Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>
#add bridge
bridge=testbridge2
./05-add_bridge.sh $bridge
#delete the bridge created
bridge_present=`brctl show | grep $bridge`
t_Log "Running $0 - Deleting the dummy bridge: $bridge"

if ! [ "$bridge_present" ]
  then
    ret_val=1
else
    t_Log "Deleting bridge $bridge"
    brctl delbr $bridge
    bridge_present=`brctl show | grep $bridge`
  if [ $bridge_present ]
  then
    ret_val=1
  else
    ret_val=0  
  fi
fi
t_CheckExitStatus $ret_val
