#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - installing acl"
t_InstallPackage  acl

t_Log "Remount root fs with acl support"
mount -o remount,acl /
sleep 2
