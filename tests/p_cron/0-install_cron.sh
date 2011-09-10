#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - Installing crond"
if (t_GetPkgRel basesystem | grep -q el6)
then
    t_InstallPackage  cronie
    service crond start
else
    t_InstallPackage  vixie-cron
    service crond start
fi

