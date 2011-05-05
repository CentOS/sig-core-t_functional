#!/bin/sh

echo 'Test that all updates can be applied to this machine cleanly'


yum -d0 -y upgrade
# yum -d0 -y upgrade > /dev/null 2>&1
if [ $? -eq 0 ]; then 
  echo ' PASS'
else
  echo ' Fail'
  exit 1
fi 
