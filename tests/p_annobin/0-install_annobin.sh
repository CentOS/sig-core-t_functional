#!/bin/bash
# Author: Neal Gompa <ngompa@datto.com>

# Skip if older than CentOS 8
if [ "$centos_ver" -lt "8" ]; then
  t_Log "annobin does not exist pre-c8 => SKIP"
  exit 0
fi

# Install annobin and gcc
t_Log "Running $0 - installing annobin and gcc."

t_InstallPackage annobin redhat-rpm-config gcc gcc-c++
