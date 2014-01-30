#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>


t_Log "Running $0 - Update /etc/hosts"

echo "$(ip a s dev eth0 | awk '$0 ~ /scope global eth0/ {print $2}' | cut -d'/' -f 1) `hostname` " >> /etc/hosts

