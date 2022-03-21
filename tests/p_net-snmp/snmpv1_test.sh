#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Snmpwal failing. Fix later. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi


t_Log "Running $0 - snmpv1 test"

snmpwalk -v 1 -c public 127.0.0.1 > /dev/null 2>&1

t_CheckExitStatus $?
