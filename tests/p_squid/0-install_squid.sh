#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - installing Squid"
t_InstallPackage  squid

# Add host entry
echo "127.0.0.1   `hostname`" >> /etc/hosts

service squid restart
t_CheckForPort 3128

