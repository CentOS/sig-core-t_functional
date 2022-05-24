#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)') && !(t_GetArch | grep -qE 'aarch64')
  then

  t_Log "Running $0 - setting hostname of system"
  eth_int=$(ip addr|grep -B 1 "link/ether"|head -n 1|awk '{print $2}'|tr -d ':')
  eth_ip=$(ip -4 addr show dev $eth_int | awk '$0 ~ /scope global/ {print $2}' | cut -d'/' -f 1)
  if [ "$centos_ver" = "7" ] ; then
    hostnamectl set-hostname c6test.c6ipa.local 
  else
    hostname c6test.c6ipa.local
  fi

  echo $eth_ip $(hostname) >> /etc/hosts
  hostname | grep "c6test.c6ipa.local" &> /dev/null
  t_CheckExitStatus $?


  t_Log "Running $0 - Configuring IPA server - this can take some time"

  ipa-server-install -U --hostname=c6test.c6ipa.local --ip-address=$eth_ip -r C6IPA.LOCAL -n c6ipa.local -p p455w0rd -a p455w0rd --ssh-trust-dns --setup-dns --forwarder=$(awk '$0 ~ /nameserver/ {print $2}' /etc/resolv.conf | head -n 1) 

  t_CheckExitStatus $?

  t_Log "Running $0 - Enabling mkhomedir"
  authconfig --enablemkhomedir --enablesssd --update
  t_CheckExitStatus $?

  if /sbin/service sssd status | grep 'is stopped' &> /dev/null
    then
    /sbin/service sssd start &> /dev/null
  fi

else
  echo "Skipped on CentOS 5 and AArch64"
fi

