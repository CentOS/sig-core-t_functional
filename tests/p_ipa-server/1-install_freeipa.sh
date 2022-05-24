#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#	  

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)') && !(t_GetArch | grep -qE 'aarch64')
  then
  t_Log "Running $0 - Installing java-1.6 to fix java-issues with 1.7/1.8, to be fixed with 6.7"
  t_InstallPackage java-1.6.0-openjdk
  t_Log "Running $0 - Installing packages, this takes around 2-3 mins"
  t_InstallPackage ipa-server bind-dyndb-ldap libsss_sudo
else
  echo "Skipped on CentOS 5 and AArch64"
fi


