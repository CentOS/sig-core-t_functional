#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -q el6)
then

t_Log "Running $0 - Restoring up resolv.conf"
cp /tmp/resolv.conf.ipa-tests /etc/resolv.conf

t_Log "Running $0 - Restoring nsswitch.conf"
cp /tmp/nsswitch.conf.ipa-tests /etc/nsswitch.conf

t_Log "Running $0 - Restoring  hosts file"
cp /tmp/hosts.ipa-tests /etc/hosts

t_Log "Running $0 - Rolling back to yum history id"
/usr/bin/yum -y history rollback $(cat /tmp/yum-rollback-id.ipa-tests) &> /dev/null

rm -f /tmp/*.ipa-test /etc/httpd/conf.d/*

else
    echo "Skipped on CentOS 5"
fi

