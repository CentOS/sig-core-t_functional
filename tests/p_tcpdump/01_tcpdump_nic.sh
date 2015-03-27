#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - TCPdump test to Default-GW with IPv4"

# Grabing Default-Router if NIC
def_gw=$(ip route list default|grep "default via"|head -n 1|awk '{print $3}')
eth_int=$(ip addr|grep -B 1 "link/ether"|head -n 1|awk '{print $2}'|tr -d ':')

  t_Log "Found Default-GW - starting tcpdump test"
  #Dumping 4 pings via NIC to file
  FILE='/var/tmp/nic_test.pcap'
  COUNT='4'
  tcpdump -i $eth_int -q -n -p -w $FILE &
  # If we don't wait a short time, the first paket will be missed by tcpdump
  sleep 1
  ping -q -c $COUNT -i 0.25 ${def_gw} > /dev/null 2>&1
  sleep 1
  killall -s SIGINT tcpdump
  sleep 1
  # reading from file, for each ping we should see two pakets
  WORKING=$( tcpdump -r $FILE | grep -ci icmp )
  if [ $SKIP_QA_HARNESS -eq 1 ]
    then
    # treat qa-harness and non qa-harness differently,
    # the script will always succeed outside qa, but will log results
    ret_val=0
    if [ $WORKING != $[COUNT*2] ]
      then
      t_Log "ping to Default-Gateway did not return the number of pakets we expect. "$WORKING" of "$[COUNT*2]" pakets were dumped to file"
    else
      t_Log "ping to Default-Gateway looks OK. "$WORKING" of "$[COUNT*2]" pakets were dumped to file"
    fi
  else
    # in qa-harness, which is a controlled environment, the script will fail at odd results
    if [ $WORKING == $[COUNT*2] ] || [ $WORKING -gt $[COUNT*2] ]
      then
      t_Log "QA-harness: ping to Default-Gateway looks OK. At least "$[COUNT*2]" pakets ("$WORKING") were dumped to file"
      ret_val=0
    else
      t_Log "QA-harness: ping to Default-Gateway droped pakets!! Only "$WORKING" of "$[COUNT*2]" entries were found!!"
      ret_val=1
    fi
  fi
# Remove file afterwards
/bin/rm $FILE

t_CheckExitStatus $ret_val
