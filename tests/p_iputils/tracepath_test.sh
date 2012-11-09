#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

TEST=tracepath

# Testing availability of network
if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST="wiki.centos.org"
else
  HOST="repo.centos.qa"
fi

t_Log "Running $0 - running ${TEST} to ${HOST}"
ret_val=1

IP=$(host ${HOST})
FILE=/var/tmp/tracepath_result

regex='.*address\ ([0-9.]*)'
if [[ $IP =~ $regex ]]
then
  tracepath -n ${HOST} > ${FILE}
  COUNT=$(grep -c ${BASH_REMATCH[1]} ${FILE})
  TTL=$(grep -c 'Too many hops' ${FILE})
  if [ $COUNT = 1 ]
  then
    t_Log "${TEST} reached ${HOST}"
    ret_val=0
  fi
  if ([ $COUNT = 0 ] && $ [ TTL = 1 ])
  then
    t_Log "${TEST} didn't reach ${HOST} because of too many hops. This is treated as SUCCESS."
    ret_val=1
  fi
fi

echo $ret_val
#t_CheckExitStatus $ret_val
