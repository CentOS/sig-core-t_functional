#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - nmap querys eth0 and checks for open ssh-port"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

# Grabing IP of eth0
IP=$(ip -f inet addr list eth0 | grep 'inet ')
regex='.*inet\ (.*)\/.*'
if [[ $IP =~ $regex ]]
  then
  t_Log "Found eth0 IP - starting nmap test"
  nmap ${BASH_REMATCH[1]} | grep -iq ssh
fi

t_CheckExitStatus $?
