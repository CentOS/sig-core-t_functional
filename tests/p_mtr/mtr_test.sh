#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

TEST=mtr

# Testing availability of network
if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST="ci.centos.org"
else
  HOST="repo.centos.qa"
fi

t_Log "Running $0 - running ${TEST} to ${HOST}"
ret_val=1

IP=$(host ${HOST})

regex='.*address\ ([0-9.]*)'
if [[ $IP =~ $regex ]]
then
  COUNT=$( mtr -nr -c1 ${HOST} | grep -c ${BASH_REMATCH[1]} )
  if [ $COUNT = 1 ]
  then
    t_Log "${TEST} reached ${HOST}"
    ret_val=0
  else
    t_Log "${TEST} didn't reach ${HOST}"
    ret_val=1
  fi
fi

t_CheckExitStatus $ret_val
