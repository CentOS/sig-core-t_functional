#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - installing libvirt"
t_InstallPackage  libvirt
service libvirtd restart
