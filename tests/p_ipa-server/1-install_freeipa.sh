#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#	  

if (t_GetPkgRel basesystem | grep -q el6)
then
t_Log "Running $0 - Installing packages"
t_InstallPackage ipa-server bind-dyndb-ldap libsss_sudo &> /dev/null
else
    echo "Skipped on CentOS 5"
fi


