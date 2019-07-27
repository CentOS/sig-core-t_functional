#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$centos_ver" -ge 8 ] ;then
  exit 0
fi
t_Log "Running $0 - check that jwhois can connect to whois server and get the info."

# Dummy whois server
echo 'tf_jwhois_test_response' | nc -l 43 &
sleep 1

whois -h 127.0.0.1 domain.tld | grep -q 'tf_jwhois_test_response'

t_CheckExitStatus $?
