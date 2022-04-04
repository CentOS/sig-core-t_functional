#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Rene Diepstraten <rene@renediepstraten.nl>

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "Running $0 - arpwatch on interface with default gateway"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

# arpwatch is broken in el7
# See https://bugzilla.redhat.com/show_bug.cgi?id=1044062
[[ $centos_ver -eq 7 ]] && { 
  t_Log "arpwatch is broken on el7. Skipping test." 
  exit
}

# Kill arpwatch instance from previous test
# killall arpwatch

# getting IP-address of default gateway
defgw=$(ip route | awk '/^default via/ {print $3}')
if [ -z $defgw ]
  then
  t_Log "No default gateway, can't test arpwatch"
  exit
fi

# setting path to arp.dat
if (t_GetPkgRel basesystem | grep -q el5)
  then
  arpdat='/var/arpwatch/arp.dat'
else
  arpdat='/var/lib/arpwatch/arp.dat'
fi

# beginning and running test
arpwatch
sleep 4
arp -d $defgw
sleep 4
ping -q -i 1 -c 5 $defgw
killall arpwatch
sleep 2
grep -q $defgw $arpdat

t_CheckExitStatus $?

# cleaning up
cat /dev/null > $arpdat

