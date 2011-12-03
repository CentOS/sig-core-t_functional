#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - installing rsync and xinetd."
t_InstallPackage xinetd rsync

# enable rsync in /etc/xinet.d/rsync
sed -i 's/\(disable\s*=\ \)yes/\1no/' /etc/xinetd.d/rsync

# Restart in case previous tests allready installed xinetd
t_ServiceControl xinetd restart
