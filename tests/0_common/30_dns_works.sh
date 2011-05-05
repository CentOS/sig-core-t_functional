#!/bin/sh

echo 'Test to see if dns works'

# test
# its important we dont hit a dns record with a wildcard like centos.org
ping -c 1 www.google.com > /dev/null 2>&1
if [ $? -eq 0 ]; then 
  echo ' PASS'
else
  echo ' Fail'
  exit 1
fi 


# implied results:
# - network works
# - default route is really routeable
# - atleast one network link on the machine is working
# - kernel' ip stack is functional


