#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>

t_Log "Running $0 - snmp test"

t_InstallPackage net-snmp-utils 

snmpwalk -v 2c -c public 127.0.0.1 > /dev/null 2>&1

t_CheckExitStatus $?
