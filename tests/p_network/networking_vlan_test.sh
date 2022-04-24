#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - create VLAN IF, assign IP on VLAN IF and tear down VLAN IF using IP command test (not on C5)"
ret_val=0

if [ $centos_ver -lt 6 ]
then
  t_Log ' This is a C5 system, skipping test'
  exit 0
fi  

t_Log 'This is no C5-system, commencing test'

export eth_int=$(ip addr|grep -B 1 "link/ether"|head -n 1|awk '{print $2}'|tr -d ':')

# create VLAN-IF 10 on ethernet device
ip link add dev ${eth_int}.10 link ${eth_int} type vlan id 10
ip addr list | grep -q ${eth_int}.10
if [ $? == 1 ]
  then
  t_Log "VLAN-IF creation failed"
  ret_val=1
else
  t_Log "VLAN-IF successfully created"
fi

#assign IP address on VLAN-IF
ip address add 172.16.30.1/32 dev ${eth_int}.10
ip addr list | grep -q 172.16.30.1
if [ $? == 1 ]
  then
  t_Log "IP address assignment on ${eth_int}.10 failed"
  ret_val=1
else
  t_Log "IP address successfully assigned on ${eth_int}.10"
fi

#testing address with ping
ping -c 4 -q 172.16.30.1 | grep -q '4 received'
if [ $? == 1 ]
  then
  t_Log "pinging on ${eth_int}.10 failed"
  ret_val=1
else
  t_Log "local ping on VLAN IF worked"
fi

# delete VLAN-IF 10 on ethernet interface
ip link delete ${eth_int}.10
ip addr list | grep -q ${eth_int}.10
if [ $? == 0 ]
  then
  t_Log "Removing VLAN IF failed"
  ret_val=1
else
  t_Log "Removing of VLAN IF worked"
fi

t_CheckExitStatus $ret_val
