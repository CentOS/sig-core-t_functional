#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>

t_Log "Running $0 - freeradius-access test"

t_InstallPackage freeradius-utils

# Make Backup of /etc/raddb/users and add testuser steve
/bin/cp /etc/raddb/users /etc/raddb/users.orig
echo 'steve  Cleartext-Password := "centos"' >> /etc/raddb/users
echo '       Service-Type = Framed-User,' >> /etc/raddb/users

# Restart Service
service radiusd restart

#Run test
WORKING=$(radtest -d /etc/raddb -x steve centos 127.0.0.1:1812 1 testing123 |grep -c 'Access-Accept')
if [ $WORKING == 1 ]; then ret_val=0
fi

# Restore settings
/bin/cp /etc/raddb/users.orig /etc/raddb/users
service radiusd restart

t_CheckExitStatus $ret_val
