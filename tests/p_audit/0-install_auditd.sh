#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>

# Install net-snmp
t_InstallPackage audit

# activate at boot
chkconfig auditd on
# start daemon with default settings
t_ServiceControl auditd start
