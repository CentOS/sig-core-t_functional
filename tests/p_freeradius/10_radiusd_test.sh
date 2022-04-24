#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjodj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Freeradius doesn't work. FIX LATER. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi


t_Log "Running $0 - freeradius-access test"

# Make Backup of /etc/raddb/users and add testuser steve
/bin/cp /etc/raddb/users /etc/raddb/users.orig
echo 'steve  Cleartext-Password := "centos"' >> /etc/raddb/users
echo '       Service-Type = Framed-User' >> /etc/raddb/users

# Restart Service
service radiusd restart

#Run test

t_Log "Running Test"
echo "User-Name=steve,User-Password=centos " | radclient -x localhost:1812 auth testing123 |grep -q 'Access-Accept'
ret_val=$?

# Restore settings
/bin/cp /etc/raddb/users.orig /etc/raddb/users
rm -rf /etc/raddb/users.orig
service radiusd stop

t_CheckExitStatus $ret_val
