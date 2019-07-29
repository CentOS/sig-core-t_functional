#!/bin/bash
# Author Dries Verachtert <dries.verachtert@dries.eu>

# Install python-iniparse: required by yum so a quite important package in CentOS
t_Log "Running $0 - installing python-iniparse."

if [ "$centos_ver" -ge 8 ] ; then
t_InstallPackage python3-iniparse
else
t_InstallPackage python-iniparse
fi
