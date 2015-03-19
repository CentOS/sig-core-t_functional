#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#	  

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)')
  then
  t_Log "Running $0 - Installing packages, this takes around 2-3 mins"
  t_InstallPackage ipa-server bind-dyndb-ldap libsss_sudo
else
  echo "Skipped on CentOS 5"
fi


