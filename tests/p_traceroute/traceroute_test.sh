#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - running traceroute to default gateway"

# Grabing default gateway of eth0
IP=$(ip route list default | grep 'default via ')
regex='.*via\ (.*)\ dev.*'
if [[ $IP =~ $regex ]]
  then
  t_Log "Found default gw (${BASH_REMATCH[1]}) - starting traceroute test"
  COUNT=$( traceroute -n ${BASH_REMATCH[1]} | grep -c ${BASH_REMATCH[1]} )
  if [ $COUNT = 2 ]
  then
    t_Log "traceroute reached default gw"
    ret_val=0
  else
    t_Log "traceroute didn't reach default gw ${BASH_REMATCH[1]}"
    ret_val=1
  fi
else
  t_Log "no default gateway found - skipping"
  ret_val=0
fi

t_CheckExitStatus $ret_val
