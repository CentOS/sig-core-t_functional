#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - running traceroute to webhost"

# Testing availability of network
if [ $SKIP_QA_HARNESS ]; then
  HOST="www.centos.org"
else
  HOST="repo.centos.qa"
fi

ping -q -c 5 -i 0.25 ${HOST}
if [ $? = 0 ]
then
  t_Log "$HOST is available - continuing"
  COUNT=$( traceroute ${HOST} | grep -c ${HOST} )
  if [ $COUNT = 2 ]
  then
    t_Log "traceroute reached ${HOST} and nslookup seems to work, too"
    ret_val=0
  else
    t_Log "traceroute didn't reach ${HOST}"
    ret_val=1
  fi
else
  t_Log "$HOST seems to be unavailable - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
