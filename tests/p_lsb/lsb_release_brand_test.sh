#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. redhat-lsb not present. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "Running $0 - LSB $os_name branding check."

lsb_release -i | grep -q "$os_name" && \
lsb_release -d | grep -q "$os_name"

t_CheckExitStatus $?
