#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -q el6)
then

t_Log "Running $0 - Stopping and removing httpd if present"
if  /sbin/service httpd status | grep 'is running...' &> /dev/null
then
/sbin/service httpd stop &> /dev/null
fi
if rpm -q httpd &> /dev/null
then
/usr/bin/yum -y remove httpd &> /dev/null
rm -rf /etc/httpd
fi

t_Log "Running $0 - Stopping and removing bind if present"
if  /sbin/service named status | grep 'is running...' &> /dev/null
then
/sbin/service named stop &> /dev/null
fi
if rpm -q bind &> /dev/null
then
/usr/bin/yum -y remove bind &> /dev/null
rm -rf /etc/named /var/named
fi


t_Log "Running $0 - Backing up resolv.conf"
cp /etc/resolv.conf /tmp/resolv.conf.ipa-tests

t_Log "Running $0 - Backing up nsswitch.conf"
cp /etc/nsswitch.conf /tmp/nsswitch.conf.ipa-tests

t_Log "Running $0 - Backing up hosts file"
cp /etc/hosts /tmp/hosts.ipa-tests

t_Log "Running $0 - Backing up saving yum history id"
/usr/bin/yum history list | awk 'NR == 4 {print $1}' > /tmp/yum-rollback-id.ipa-tests

else
    echo "Skipped on CentOS 5"
fi

