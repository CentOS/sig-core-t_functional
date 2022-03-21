#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. mailman not present. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "$0 - Installing mailman"
t_InstallPackage  mailman

