#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

if [ $CONTAINERTEST -eq 1 ]; then
	    echo "Skipping this test ..."
else

t_Log "Running $0 - Installing required packages"

if [ "$centos_ver" = "5" ] ; then
   t_InstallPackage autofs nfs-utils portmap
else
   t_InstallPackage autofs nfs-utils rpcbind 
fi


t_Log 'Preparing NFS-Share and starting NFS-Server'
echo '/var/lib/ 127.0.0.1(ro)' >> /etc/exports

if [ "$centos_ver" = "5" ] ; then
   t_ServiceControl portmap restart
   t_ServiceControl nfs restart
elif [ "$centos_ver" -ge 8 ] ; then
   t_ServiceControl rpcbind restart
   t_ServiceControl nfs-server restart
else
   t_ServiceControl rpcbind restart
   t_ServiceControl nfs restart
fi


t_Log 'verify if NFS is mountable'
mount -t nfs 127.0.0.1:/var/lib /mnt
ls -al /mnt | egrep -q '(dnf|yum)'

t_CheckExitStatus $?
umount /mnt
fi
