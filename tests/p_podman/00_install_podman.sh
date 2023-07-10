#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - installing podman."

if [ "$centos_ver" -lt 8 ] ; then
  t_Log "SKIP $0: only install in centos stream 8 or greater"
  exit 0
fi

t_InstallPackage podman
