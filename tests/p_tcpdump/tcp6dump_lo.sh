#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - TCPdump test IPv6 to lo"

# Grabing IPv6 address of lo to checl if IPv6 is enabled
IP=$(ip addr list lo | grep 'inet6 ')
regex='\t*inet6\ (.*)\/.*'
if [[ $IP =~ $regex ]]
  then
  t_Log "IPv6 seems to be enabled - runing test"
  FILE='/var/tmp/lo_test6.pcap'
  #Dumping 4 ping6s to loopback to file
  tcpdump -q -n -p -i lo -w $FILE &
  # If we don't wait a short time, the first paket will be missed by tcpdump
  sleep 1
  ping6 -q -c 4 -i 0.25 ::1
  sleep 1
  killall -s SIGINT tcpdump

  # reading from file, for each ping we should see two pakets
  WORKING=$( tcpdump -r $FILE | grep -ci icmp6 )
  if [ $WORKING == 8 ]; then
    ret_val=0
  else
    ret_val=1
  fi
  # Remove file afterwards
  /bin/rm $FILE
else
  t_Log "IPv6 seems to be disabled - skipping test"
  ret_val=0
fi

t_CheckExitStatus $ret_val
