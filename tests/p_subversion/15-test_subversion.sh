#!/bin/bash

# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

t_Log "Running $0 - testing a local subversion repository creation operation"

if [ $centos_ver == '6' ]
  then
  temp_dir="/tmp/svnrepo"
  temp_repo="tmprepo"
  rm -rf $temp_dir/$temp_repo
  mkdir -p $temp_dir
  cd $temp_dir
  svnadmin create $temp_repo
  
#verify repo using svnadmin
  if [ "svnadmin verify $temp_dir/$temp_repo | grep 'Verified revision 0'" ] 
  then
    ret_val=0 
  else
    ret_val=1
  fi
else
  t_Log "This test is skipped in CentOS5."
  ret_val=0
fi

t_CheckExitStatus $ret_val
