#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#
if (t_GetPkgRel basesystem | grep -q el6)
then

t_Log "Running $0 - Configuring IPA server"

ipa-server-install -U --hostname=c6test.c6ipa.local --ip-address=$(ip a s dev eth0 | awk '$0 ~ /scope global eth0/ {print $2}' | cut -d'/' -f 1) -r C6IPA.LOCAL -n c6ipa.local -p p455w0rd -a p455w0rd --ssh-trust-dns --setup-dns --forwarder=$(awk '$0 ~ /nameserver/ {print $2}' /etc/resolv.conf | head -n 1) 

t_CheckExitStatus $?

t_Log "Running $0 - Enabling mkhomedir"
authconfig --enablemkhomedir --enablesssd --update
t_CheckExitStatus $?

if /sbin/service sssd status | grep 'is stopped' &> /dev/null
then
/sbin/service sssd start &> /dev/null
fi

else
    echo "Skipped on CentOS 5"
fi

