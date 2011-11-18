#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - Installing crond"
if (t_GetPkgRel basesystem | grep -q el6)
then
  pn="cronie"
else
  pn="vixie-cron"
fi

t_InstallPackage  cronie
service crond cycle
