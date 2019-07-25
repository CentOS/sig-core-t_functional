#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

# Install java
if [ $centos_ver -ge 8 ]; then
  echo "Package not included in CentOS $centos_ver, skipping"
  exit 0
fi
if (t_GetArch | grep -qE 'aarch64|ppc64le')
  then
  echo "Package not included for current arch, skipping"
  exit 0
fi

t_Log "Running $0 - installing openjdk runtime/development environment."

t_InstallPackage java-1.6.0-openjdk java-1.6.0-openjdk-devel
