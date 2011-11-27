#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# NFS
t_InstallPackage nfs-utils


if (t_GetPkgRel basesystem | grep -q el6)
then
   t_ServiceControl rpcbind restart
else
   t_ServiceControl portmap restart
fi

# Restart because usualy NFS is enabled by default on CentOS-5
t_ServiceControl nfs restart
