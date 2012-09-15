#!/bin/bash
# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

t_Log "Running $0 - installing subversion"

# Install subversion subversion 
if [ $centos_ver == '6' ]
  then
  t_InstallPackage subversion
else
  t_Log "This test is skipped in CentOS5."
fi
