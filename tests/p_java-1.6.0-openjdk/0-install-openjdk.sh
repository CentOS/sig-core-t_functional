#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

# Install python
if (t_GetArch | grep -qE 'aarch64|armv7hl|ppc64le')
  then
  echo "Package not included for current arch, skipping"
  exit 0
fi

t_Log "Running $0 - installing openjdk runtime/development environment."

t_InstallPackage java-1.6.0-openjdk java-1.6.0-openjdk-devel
