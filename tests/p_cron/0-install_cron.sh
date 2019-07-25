#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - Installing crond"
if (t_GetPkgRel basesystem | grep -q -E 'el6|el7|el8')
then
  pn="cronie"
else
  pn="vixie-cron"
fi

t_InstallPackage  $pn
t_ServiceControl crond cycle
