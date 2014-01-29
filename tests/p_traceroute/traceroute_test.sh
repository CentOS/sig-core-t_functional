#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

TEST=traceroute

# Testing availability of network
if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST="ci.dev.centos.org"
else
  HOST="repo.centos.qa"
fi

t_Log "Running $0 - running ${TEST} to ${HOST}"

IP=$(host ${HOST})
FILE=/var/tmp/traceroute_result
ret_val=1
# getting IP-address of default gateway as a fall back
defgw=$(ip route list | grep default | cut -d' ' -f3)

if [[ $IP =~ .*address\ ([0-9.]*) ]]
then
  traceroute -n ${HOST} > ${FILE}
  COUNT=$(grep -c ${BASH_REMATCH[1]} ${FILE})
  TTL=$(egrep -c '30  \* \* \*' ${FILE})
  GW=$(grep -c ${defgw} ${FILE})
  if [ $COUNT = 2 ]
  then
    t_Log "${TEST} reached ${HOST}"
    ret_val=0
  elif ([ $COUNT != 2 ] && [ $TTL = 1 ])
    then
    t_Log "${TEST} didn't reach ${HOST} because of too many hops/blocked traceroute by ISP. This is treated as SUCCESS."
    ret_val=0
  elif ([ $COUNT != 2 ] && [ $GW -gt 0 ])
    then
    t_Log "${TEST} didn't reach ${HOST} (maybe because of ACLs on the network), but at least the Default Gateway ${defgw} was reached. Treating as SUCCESS."
    ret_val=0
  else
    t_Log "${TEST} didn't return anything we expect - FAILING"
    ret_val=1
  fi
fi

/bin/rm ${FILE}
t_CheckExitStatus $ret_val
