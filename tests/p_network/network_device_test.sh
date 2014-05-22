#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Check if a least one network device is available."

ifconfig | grep -q ether

export eth_int=$(ip addr|grep -B 1 "link/ether"|head -n 1|awk '{print $2}'|tr -d ':')

t_CheckExitStatus $?
