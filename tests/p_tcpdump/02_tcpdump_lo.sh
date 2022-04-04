#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - TCPdump test to lo"


if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

#Dumping pings to loopback to file
FILE='/var/tmp/lo_test.pcap'
COUNT='4'

tcpdump -q -n -p -i lo -w $FILE &
# If we don't wait a short time, the first paket will be missed by tcpdump
sleep 1
ping -q -c $COUNT -i 0.25 127.0.0.1 > /dev/null 2>&1
sleep 1
killall -s SIGINT tcpdump
sleep 1
# reading from file, for each ping we should see two pakets
WORKING=$( tcpdump -r $FILE | grep -ci icmp )
if [ $WORKING == $[COUNT*2] ]
  then
  ret_val=0
else
  t_Log "ping to loopback droped pakets!! This should not happen on loopback"
  ret_val=1
fi

# Remove file afterwards
/bin/rm $FILE

t_CheckExitStatus $ret_val
