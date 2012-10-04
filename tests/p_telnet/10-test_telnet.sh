#!/bin/bash

# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

t_Log "Running $0 - testing telnet against ssh port"
t_Log "Making sure port 22 is listening by calling ssh installer"

t_InstallPackage openssh-server openssh-clients 
t_ServiceControl sshd start

telnet_port_22=`telnet 127.0.0.1 22 << EOH
EOH`
echo $telnet_port_22 | grep "Escape character is '^]'"
t_CheckExitStatus $?
