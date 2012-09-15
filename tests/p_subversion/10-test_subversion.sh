#!/bin/bash
# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

# Check subversion installation

t_Log "Running $0 - checking subversion installation"

if [ $centos_ver == '6' ]
  then
  svn --version &>/dev/null
  ret_val=$?
else
  t_Log "This test is skipped in CentOS5."
  ret_val=0
fi
  
t_CheckExitStatus $ret_val
