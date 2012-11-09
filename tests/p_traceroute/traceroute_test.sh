#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

TEST=traceroute

# Testing availability of network
if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST="wiki.centos.org"
else
  HOST="repo.centos.qa"
fi

t_Log "Running $0 - running ${TEST} to ${HOST}"
ret_val=1

IP=$(host ${HOST})

regex='.*address\ ([0-9.]*)'
if [[ $IP =~ $regex ]]
then
  traceroute -n ${HOST}
  COUNT=$( traceroute -n ${HOST} | grep -c ${BASH_REMATCH[1]} )
  if [ $COUNT = 2 ]
  then
    t_Log "${TEST} reached ${HOST}"
    ret_val=0
  else
    t_Log "${TEST} didn't reach ${HOST}"
    ret_val=1
  fi
fi

echo $ret_val
#t_CheckExitStatus $ret_val
