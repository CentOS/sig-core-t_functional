#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <tigalch@tigalch.org>

t_Log "$0 - installing amanda system"


if (t_GetPkgRel basesystem | grep -q el5)
then
  t_Log "This is a C5 system. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Amanda not present. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

t_InstallPackage amanda amanda-server amanda-client
id -u amandabackup &>/dev/null || useradd amandabackup 
