#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check iptables default rules"

(grep "state --state ESTABLISHED,RELATED -j ACCEPT" /etc/sysconfig/iptables > /dev/null 2>&1 ) && \

(grep "state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT" /etc/sysconfig/iptables > /dev/null 2>&1 ) && \

(grep "REJECT --reject-with icmp-host-prohibited" /etc/sysconfig/iptables > /dev/null 2>&1 )

t_CheckExitStatus $?

