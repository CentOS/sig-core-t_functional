#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

if [ "$centos_ver" -ne "8" ]; then
  t_Log "non c8 => SKIPPING"
  exit 0
fi

t_Log "Running $0 - installing beakerlib"
t_InstallPackage git make patch 
pushd /tmp
git clone https://github.com/beakerlib/beakerlib
cd beakerlib
make
make install
popd
