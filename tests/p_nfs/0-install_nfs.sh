#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# NFS
t_InstallPackage nfs-utils

if [ "$centos_ver" = "5" ] ; then
   t_serviceControl portmap restart
else
   t_ServiceControl rpcbind restart
fi

# Restart because usualy NFS is enabled by default on CentOS-5
t_ServiceControl nfs restart
