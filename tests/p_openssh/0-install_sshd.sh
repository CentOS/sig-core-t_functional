#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# SSH
t_InstallPackage openssh-server
chkconfig sshd on
t_ServiceControl sshd start
