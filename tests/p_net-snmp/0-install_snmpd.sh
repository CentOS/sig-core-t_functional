#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

# Install net-snmp
t_InstallPackage net-snmp

# start daemon with default settings
t_ServiceControl snmpd start

