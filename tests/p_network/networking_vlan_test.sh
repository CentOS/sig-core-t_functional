#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - create VLAN IF, assign IP on VLAN IF and tear down VLAN IF using IP command test"
ret_val=0

# create VLAN-IF 10 on eth0
ip link add dev eth0.10 link eth0 type vlan id 10
ip addr list | grep -q eth0.10
if [ $? == 1 ]
  then
  t_Log "VLAN-IF creation failed"
  ret_val=1
else
  t_Log "VLAN-IF successfully created"
fi

#assign IP address on VLAN-IF
ip address add 172.16.30.1/32 dev eth0.10
ip addr list | grep -q 172.16.30.1
if [ $? == 1 ]
  then
  t_Log "IP address assignment on eth0.10 failed"
  ret_val=1
else
  t_Log "IP address successfully assigned on eth1.10"
fi

#testing address with ping
ping -c 4 -q 172.16.30.1 | grep -q '4 received'
if [ $? == 1 ]
  then
  t_Log "pinging on eth0.10 failed"
  ret_val=1
else
  t_Log "local ping on VLAN IF worked"
fi

# delete VLAN-IF 10 on eth0
ip link delete eth0.10
ip addr list | grep -q eth0.10
if [ $? == 0 ]
  then
  t_Log "Removing VLAN IF failed"
  ret_val=1
else
  t_Log "Removing of VLAN IF worked"
fi

t_CheckExitStatus $ret_val
