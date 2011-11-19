#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - TCPdump test to lo"

#Dumping 4 pings to loopback to file
FILE='/var/tmp/lo_test.pcap'

tcpdump -q -n -p -i lo -w $FILE &
# If we don't wait a short time, the first paket will be missed by tcpdump
sleep 1
ping -q -c 4 -i 0.25 127.0.0.1
sleep 1
killall -s SIGINT tcpdump

# reading from file, for each ping we should see two pakets
WORKING=$( tcpdump -r $FILE | grep -ci icmp )
if [ $WORKING == 8 ]
  then
  ret_val=0
else
  ret_val=1
fi

# Remove file afterwards
/bin/rm $FILE

t_CheckExitStatus $ret_val
