#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - snmpv2c test"

t_InstallPackage net-snmp-utils 

snmpwalk -v 2c -c public 127.0.0.1 > /dev/null 2>&1

t_CheckExitStatus $?
