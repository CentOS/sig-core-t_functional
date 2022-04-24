#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - TCPdump test IPv6 to lo"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

# Grabing IPv6 address of lo to check if IPv6 is enabled
IP=$(ip addr list lo | grep 'inet6 ')
regex='\t*inet6\ (.*)\/.*'
if [[ $IP =~ $regex ]]
  then
  t_Log "IPv6 seems to be enabled - runing test"
  FILE='/var/tmp/lo_test6.pcap'
  COUNT='4'
  #Dumping ping6s to loopback to file
  tcpdump -q -n -p -i lo -w $FILE &
  # If we don't wait a short time, the first paket will be missed by tcpdump
  sleep 1
  ping6 -q -c $COUNT -i 0.25 ::1 > /dev/null 2>&1
  sleep 1
  killall -s SIGINT tcpdump
  sleep 1

  # reading from file, for each ping we should see two pakets
  WORKING=$( tcpdump -r $FILE | grep -ci icmp6 )
  if [ $WORKING == $[COUNT*2] ]; then
    ret_val=0
  else
    t_Log "ping6 to loopback droped pakets!! This should not happen on loopback"
    ret_val=1
  fi
  # Remove file afterwards
  /bin/rm $FILE
else
  t_Log "IPv6 seems to be disabled - skipping test"
  ret_val=0
fi

t_CheckExitStatus $ret_val
