#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

TEST=mtr

# Testing availability of network
if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST="ci.centos.org"
else
  HOST="repo.centos.qa"
fi

t_Log "Running $0 - running ${TEST} to ${HOST}"
ret_val=1
FILE=/var/tmp/mtr_result

IP=$(dig +short ${HOST} A ${HOST} AAAA)

if [[ ! -z "$IP" ]]
then
  t_Log "${HOST} IPs:\n${IP}"
  mtr -nr -c1 ${HOST} > ${FILE}
  t_Log "Results of 'mtr -nr -c1 ${HOST}':"
  cat ${FILE}
  COUNT=$(echo "$IP" | grep -cf - ${FILE})
  if [ $COUNT = 1 ]
  then
    t_Log "${TEST} reached ${HOST}"
    ret_val=0
  else
    t_Log "${TEST} didn't reach ${HOST}"
    ret_val=1
  fi
fi

/bin/rm ${FILE}
t_CheckExitStatus $ret_val
