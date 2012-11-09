#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check iptables default rules"

if [ $SKIP_QA_HARNESS -eq 1 ]; then
  echo "Skip, No standard firewall config ..."
else

(grep "state --state ESTABLISHED,RELATED -j ACCEPT" /etc/sysconfig/iptables > /dev/null 2>&1 ) && \

(grep "state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT" /etc/sysconfig/iptables > /dev/null 2>&1 ) && \

(grep "REJECT --reject-with icmp-host-prohibited" /etc/sysconfig/iptables > /dev/null 2>&1 )

fi

t_CheckExitStatus $?

