#!/bin/bash
# Author: Madhurranjan Mohaan <mohanma@thoughtworks.com>

# Install bridge_utils package
t_Log "Running $0 - bridge-utils: Installation"

if [ "$centos_ver" -ge 8 ] ; then
t_InstallPackage iproute
else
t_InstallPackage bridge-utils
fi
