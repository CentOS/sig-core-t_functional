#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - iptables functional check - deny ping on loopback"

if [ "$centos_ver" -ge 7 ];then
 t_Log "CentOS $centos_ver uses firewalld and not iptables -> SKIP"
 t_CheckExitStatus 0
 exit 0
fi


ACL='INPUT -s 127.0.0.1/32 -d 127.0.0.1/32 -p icmp -m icmp -j REJECT'
COUNT='4'
DEADTIME='1'

# ensure we have the default iptables-setting
#/etc/init.d/iptables restart > /dev/null
service iptables restart

# Verify it worked previously
ping -q -c $COUNT -i 0.25 127.0.0.1 |grep -qc "${COUNT} received"

if [ $? == 1 ]
  then
  t_Log "ping to loopback failed prior to test, this should not happen"
  t_CheckExitStatus 1
fi

# Applying ACL
iptables -I ${ACL}

ping -q -c $COUNT -i 0.25 -w $DEADTIME 127.0.0.1 > /dev/null 2>&1
if [ $? == 1 ]
  then
  t_Log "iptables REJECT works fine"
  ret_val=0
else
  ret_val=1
fi

# cleanup
service iptables restart
#/etc/init.d/iptables restart > /dev/null

t_CheckExitStatus $ret_val

