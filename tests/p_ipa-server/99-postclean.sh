#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)')
then

t_Log "Running $0 - Restoring up resolv.conf"
cp /tmp/resolv.conf.ipa-tests /etc/resolv.conf

t_Log "Running $0 - Restoring nsswitch.conf"
cp /tmp/nsswitch.conf.ipa-tests /etc/nsswitch.conf

t_Log "Running $0 - Restoring  hosts file"
cp /tmp/hosts.ipa-tests /etc/hosts

if [[ -f /tmp/ntp.conf.ipa-tests ]]
then
t_Log "Running $0 - Restoring  ntp.conf file"
cp /tmp/ntp.conf.ipa-tests /etc/ntp.conf
fi

t_Log "Running $0 - Rolling back to yum history id - this will take some time"
/usr/bin/yum -y history rollback $(cat /tmp/yum-rollback-id.ipa-tests) &> /dev/null

rm -f /tmp/*.ipa-test /etc/httpd/conf.d/*
sed -i "s/$(ip a s dev eth0 | awk '$0 ~ /scope global eth0/ {print $2}' | cut -d'/' -f 1) $(hostname)//" /etc/hosts
hostname localhost.localdomain

else
    echo "Skipped on CentOS 5"
fi

