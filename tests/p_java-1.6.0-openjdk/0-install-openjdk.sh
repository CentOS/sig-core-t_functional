#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

# Install java
if (t_GetArch | grep -qE 'aarch64|ppc64le')
  then
  echo "Package not included for current arch, skipping"
  exit 0
fi

t_Log "Running $0 - installing openjdk runtime/development environment."

t_InstallPackage java-1.6.0-openjdk java-1.6.0-openjdk-devel
