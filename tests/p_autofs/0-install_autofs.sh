#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log 'Running $0 - Installing required packages'
t_InstallPackage autofs nfs-utils rpcbind

t_Log 'Preparing NFS-Share and starting NFS-Server'
echo '/var/lib/ 127.0.0.1(ro)' >> /etc/exports
t_ServiceControl rpcbind restart
t_ServiceControl nfs restart

t_Log 'verify if NFs is mountable'
mount -t nfs 127.0.0.1:/var/lib /mnt
ls -al /mnt | grep -q yum

t_CheckExitStatus $?
umount /mnt
