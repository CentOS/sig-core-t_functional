#!/bin/sh

echo 'Test that all 32 rpms can be removed'

# only run this test on x86_64 machines!
is64=$(uname -m|grep x86_64)
if [ "$?" -ne '0' ]; then
  echo ' Skip'
  exit 1
fi

yum -d0 -y erase *.i?86 
#yum -d0 -y erase *.i?86 > /dev/null 2>&1
if [ $? -eq 0 ]; then 
  echo ' PASS'
else
  echo ' Fail'
  exit 1
fi 

# note, this does not imply the machine is usable after the remove! need
# to test that independantly 
