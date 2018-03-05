#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

uname_arch=$(uname -m)

if [ "$uname_arch" == "armv7l" ]; then
  t_Log "*** Not testing on Arch: $uname_arch ***"
  exit 0
fi 
# Install python
if (t_GetArch | grep -qE 'aarch64|armv7hl|ppc64le')
  then
  echo "Package not included for current arch, skipping"
  exit 0
fi

t_Log "Running $0 - installing openjdk runtime/development environment."

t_InstallPackage java-1.6.0-openjdk java-1.6.0-openjdk-devel
