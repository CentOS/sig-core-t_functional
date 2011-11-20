#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjodj <athmanem@gmail.com>

t_Log "Running $0 - freeradius-access test"

if (t_GetPkgRel basesystem | grep -q el6)
  then
  t_InstallPackage freeradius-utils
else 
  t_InstallPackage freeradius2-utils
fi

# Make Backup of /etc/raddb/users and add testuser steve
/bin/cp /etc/raddb/users /etc/raddb/users.orig
echo 'steve  Cleartext-Password := "centos"' >> /etc/raddb/users
echo '       Service-Type = Framed-User,' >> /etc/raddb/users

# Restart Service
service radiusd restart

#Run test, treat C6 and C5 differently

if (t_GetPkgRel basesystem | grep -q el6)
  then
  t_Log "Running C6-Test"
  radtest -d /etc/raddb -x steve centos 127.0.0.1:1812 1 testing123 |grep -qc 'Access-Accept'
  ret_val=$?
else
  t_Log "Running C5-Test"
  radtest steve centos 127.0.0.1:1812 1 testing123 |grep -qc 'Access-Accept'
  ret_val=$?
fi

# Restore settings
/bin/cp /etc/raddb/users.orig /etc/raddb/users
rm -rf /etc/raddb/users.orig
service radiusd restart

t_CheckExitStatus $ret_val
