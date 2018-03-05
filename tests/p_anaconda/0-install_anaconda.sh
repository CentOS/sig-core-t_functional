#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

uname_arch=$(uname -m)

if [ "$uname_arch" == "armv7l" ]; then
  t_Log "*** Not testing on Arch: $uname_arch ***"
  exit 0
fi 

t_InstallPackage anaconda
