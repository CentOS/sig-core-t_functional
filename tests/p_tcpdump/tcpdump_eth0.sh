#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - TCPdump test to Default-GW with IPv4"

# Grabing Default-Router of eth0
IP=$(ip route list default | grep 'default via ')
regex='.*via\ (.*)\ dev.*'
if [[ $IP =~ $regex ]]
  then
  t_Log "Found Default-GW - starting tcpdump test"
  #Dumping 4 pings via eth0 to file
  FILE='/var/tmp/eth0_test.pcap'
  COUNT='4'
  tcpdump -q -n -p -i eth0 -w $FILE &
  # If we don't wait a short time, the first paket will be missed by tcpdump
  sleep 1
  ping -q -c $COUNT -i 0.25 ${BASH_REMATCH[1]} > /dev/null 2>&1
  sleep 1
  killall -s SIGINT tcpdump
  sleep 1
  # reading from file, for each ping we should see two pakets
  WORKING=$( tcpdump -r $FILE | grep -ci icmp )
  # The script will allways work, but if the log does not contain
  # what we expect, we will log it
  if [ $WORKING == $[COUNT*2] ]
    then
    ret_val=0
  else
    t_Log "ping to Default-Gateway droped pakets!! Only "$WORKING" of "$[COUNT*2]" entries were found!!"
    ret_val=1
  fi
else
  t_Log "No Default-GW found - skiping test"
  ret_val=0
fi
# Remove file afterwards
/bin/rm $FILE

t_CheckExitStatus $ret_val
