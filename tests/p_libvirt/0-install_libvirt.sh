#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - installing libvirt"
t_InstallPackage  libvirt
service libvirtd restart
