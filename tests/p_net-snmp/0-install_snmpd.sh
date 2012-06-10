#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install net-snmp"

# Install net-snmp
t_InstallPackage net-snmp

# start daemon with default settings
t_ServiceControl snmpd start

