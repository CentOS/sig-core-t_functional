#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 -installing libbpf-tools."
if [ "$centos_ver" -ge 9 ] ; then
 t_InstallPackage libbpf-tools
else
 t_Log "Skip on less than EL9"
fi
