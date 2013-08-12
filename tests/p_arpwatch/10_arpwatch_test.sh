#!/bin/sh
#         Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - arpwatch on eth0"

# Kill arpwatch instance from previous test
# killall arpwatch

# getting IP-address of default gateway
defgw=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
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
more $arpdat
grep -q $defgw $arpdat

t_CheckExitStatus $?

# cleaning up
cat /dev/null > $arpdat

