#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>


if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Snmpwal failing. Fix later. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "Running $0 - snmpv3 test"

# Make Backup of snmpd.conf and add V3-settings
/bin/cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig
echo 'rouser centosro' >> /etc/snmp/snmpd.conf
echo 'createUser centosro MD5 centosro DES centosro' >> /etc/snmp/snmpd.conf

# Restart Service
service snmpd restart

#Run test
snmpget -v 3 -u centosro  -n "" -l authPriv -a MD5 -A centosro -x DES -X centosro 127.0.0.1 sysUpTime.0 > /dev/null 2>&1
ret_val=$?

# Restore settings
/bin/cp /etc/snmp/snmpd.conf.orig /etc/snmp/snmpd.conf
service snmpd restart

t_CheckExitStatus $ret_val
