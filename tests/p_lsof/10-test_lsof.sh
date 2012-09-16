#!/bin/bash

# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

t_Log "Running $0 - testing lsof against ssh port"

t_InstallPackage openssh-server openssh-clients 
t_ServiceControl sshd start

sshd_port_listening=`lsof -i:22 | grep LISTEN`
if [ "$sshd_port_listening" ]
then
  t_Log "Ssh port 22 is in the listening mode"
  ret_val=0
else 
  ret_val=1
fi
t_CheckExitStatus $ret_val
