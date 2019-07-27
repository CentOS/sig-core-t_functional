#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - installing rsync and xinetd."

if [ "$centos_ver" = "8" ] ; then
  t_InstallPackage xinetd rsync rsync-daemon
else
  t_InstallPackage xinetd rsync
fi

# Restart in case previous tests allready installed xinetd
if [ "$centos_ver" = "7" ] || [ "$centos_ver" = "8" ]; then
 systemctl start rsyncd.service
else
 # enable rsync in /etc/xinet.d/rsync
 sed -i 's/\(disable\s*=\ \)yes/\1no/' /etc/xinetd.d/rsync
 t_ServiceControl xinetd restart
fi
