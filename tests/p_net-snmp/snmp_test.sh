#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - snmp test"

t_InstallPackage net-snmp-utils 

snmpwalk -v 1 -c public 127.0.0.1 > /dev/null 2>&1

t_CheckExitStatus $?
