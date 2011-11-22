#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage tftp-server xinetd tftp

# Enable tftp
sed -i 's/\(disable\s*=\ \)yes/\1no/' /etc/xinetd.d/tftp

t_ServiceControl xinetd restart
