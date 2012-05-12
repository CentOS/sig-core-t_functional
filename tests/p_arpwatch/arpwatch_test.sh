#!/bin/sh
#         Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - arpwatch on eth0"

# getting IP-address of default gateway
defgw=$(ip route list | grep default | cut -d' ' -f3)

# setting path to arp.dat
if (t_GetPkgRel basesystem | grep -q el5)
  then
  arpdat='/var/arpwatch/arp.dat'
else
  arpdat='/var/lib/arpwatch/arp.dat'
fi

# beginning and running test
arpwatch
sleep 1
arp -d $defgw
sleep 1
ping -q -i 0.25 -c 5 $defgw
killall arpwatch
sleep 1
grep -q $defgw $arpdat
ret_val=$?

# cleaning up
cat /dev/null > $arpdat

t_CheckExitStatus $ret_val
