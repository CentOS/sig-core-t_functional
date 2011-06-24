#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# NFS
t_InstallPackage nfs-utils

# Restart because usualy NFS is enabled by default on CentOS-5
t_ServiceControl nfs restart
t_ServiceControl portmap restart
