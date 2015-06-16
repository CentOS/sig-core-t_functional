#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)') && !(t_GetArch | grep -qE 'aarch64')
  then
  if (t_GetPkgRel basesystem | grep -qE 'el(6)')
    then
    CP=/bin/cp
  fi
  if (t_GetPkgRel basesystem | grep -qE 'el(7)')
    then
    CP=/usr/bin/cp
  fi

  t_Log "Running $0 - Restoring up resolv.conf"
  ${CP} /tmp/resolv.conf.ipa-tests /etc/resolv.conf

  t_Log "Running $0 - Restoring nsswitch.conf"
  ${CP} /tmp/nsswitch.conf.ipa-tests /etc/nsswitch.conf

  t_Log "Running $0 - Restoring  hosts file"
  ${CP} /tmp/hosts.ipa-tests /etc/hosts

  if [[ -f /tmp/ntp.conf.ipa-tests ]]
    then
    t_Log "Running $0 - Restoring  ntp.conf file"
    ${CP} /tmp/ntp.conf.ipa-tests /etc/ntp.conf
  fi

  t_Log "Running $0 - Rolling back to yum history id - this will take some time"
    /usr/bin/yum -y history rollback $(cat /tmp/yum-rollback-id.ipa-tests) &> /dev/null

  t_Log "Running $0 - Restoring ssh_config"
  ${CP} /etc/ssh/ssh_config.ipa-tests /etc/ssh/ssh_config

  
  rm -f /tmp/*.ipa-test /etc/httpd/conf.d/*

  if [ "$centos_ver" = "7" ] ; then
    hostnamectl set-hostname $(cat /tmp/hostname.ipa-tests) 
  else
    hostname $(cat /tmp/hostname.ipa-tests)
  fi

else
    echo "Skipped on CentOS 5 and AArch64"
fi

