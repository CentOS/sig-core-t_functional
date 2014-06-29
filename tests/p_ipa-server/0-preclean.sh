#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)')
  then

  t_Log "Running $0 - Stopping and removing httpd if present"
  if  /sbin/service httpd status 2>&1 | grep 'running...' &> /dev/null
    then
    /sbin/service httpd stop &> /dev/null
  fi
  if rpm -q httpd &> /dev/null
    then
    /usr/bin/yum -y remove httpd &> /dev/null
   rm -rf /etc/httpd
  fi

  t_Log "Running $0 - Stopping and removing bind if present"
  if  /sbin/service named status 2>&1 | grep 'running...' &> /dev/null
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

  t_Log "Running $0 - Saving current hostname"
  echo $(hostname) >/tmp/hostname.ipa-tests

  if [[ -f /etc/ntp.conf ]]
    then
    t_Log "Running $0 - Backing up ntp.conf file"
    cp /etc/ntp.conf /tmp/ntp.conf.ipa-tests
  fi

  t_Log "Running $0 - Backing up saving yum history id"
  /usr/bin/yum history list | awk 'NR == 4 {print $1}' > /tmp/yum-rollback-id.ipa-tests

  t_Log "Running $0 - Cleaning up hosts file"
  sed -i "s/127.0.0.1 $(hostname)//" /etc/hosts
  
  t_Log "Running $0 - Cleaning previous tomcat/pki instances if any"
  yum remove -d0 -y tomcat ipa-server >/dev/null 2>&1
  /bin/rm -Rf /var/lib/pki/pki-tomcat/ /etc/sysconfig/pki-tomcat /var/log/pki/pki-tomcat /etc/pki/pki-tomcat /etc/sysconfig/pki/tomcat/pki-tomcat

  t_Log "Running $0 - Backing up ssh_config"
  cp /etc/ssh/ssh_config /etc/ssh/ssh_config.ipa-tests

else
    echo "Skipped on CentOS 5"
fi

