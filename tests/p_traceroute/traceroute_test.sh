#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

TEST=traceroute
t_Log "Running $0 - running ${TEST} to webhost"

# Testing availability of network
if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST="www.centos.org"
else
  HOST="repo.centos.qa"
fi

IP=$(ping -qn -c 1 ${HOST} | grep -i 'ping '${HOST})

regex='PING\ '${HOST}'\ \(([0-9.]*)\).*'
if [[ $IP =~ $regex ]]
then
  t_Log "resolved ${HOST} successfully - continuing"
  ping -q -c 2 -i 0.25 ${HOST}
  if [ $? = 0 ]
  then
    t_Log "$HOST is reachable - continuing"
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
else
  t_Log "$HOST seems to be unavailable - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
