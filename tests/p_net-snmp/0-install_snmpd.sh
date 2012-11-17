#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install net-snmp, net-snmp-utils"

# Install net-snmp and net-snmp-utils
t_InstallPackage net-snmp net-snmp-utils

# start daemon with default settings
t_ServiceControl snmpd start

