#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - create VLAN IF, assign IP on VLAN IF and tear down VLAN IF test"
ret_val=0

if [ $centos_ver -gt 6 ]
then
  t_Log 'vconfig is only supported on C5 and C6, skipping'
  t_CheckExitStatus $ret_val
  exit 0
fi

# create VLAN-IF 10 on eth0
vconfig add eth0 10
ip addr list | grep -q eth0.10
t_CheckExitStatus $? "VLAN-IF creation failed"
t_Log "VLAN-IF successfully created"

#assign IP address on VLAN-IF
ifconfig eth0.10 172.16.30.1 netmask 255.255.255.255
ip addr list | grep -q 172.16.30.1
t_CheckExitStatus $? "IP address assignment on eth0.10 failed"
t_Log "IP address successfully assigned on eth0.10"

#testing address with ping
ping -c 4 -q 172.16.30.1 | grep -q '4 received'
t_CheckExitStatus $? "pinging on eth0.10 failed"
t_Log "local ping on VLAN IF worked"

# delete VLAN-IF 10 on eth0
vconfig rem eth0.10
ip addr list | grep -q eth0.10
t_CheckExitStatus $? "Removing VLAN IF failed"
t_Log "Removing of VLAN IF worked"
