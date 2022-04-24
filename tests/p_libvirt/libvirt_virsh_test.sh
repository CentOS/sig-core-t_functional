#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

if (t_GetArch | grep -qE 'aarch64')
  then
  echo "Package not included with AArch64, skipping"
  exit 0
fi

t_Log "Running $0 - libvirt: Virsh can talk to local hypervisor."

virsh -c test:///default list  > /dev/null

t_CheckExitStatus $?
