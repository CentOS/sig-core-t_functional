#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage sendmail

# Remove other MTAs
t_ServiceControl postfix stop
sleep 3
t_RemovePackage postfix
if (t_GetPkgRel basesystem | grep -q el5)
then
  #also stoping/removing exim
  t_ServiceControl exim stop
  sleep 3
  t_RemovePackage exim
fi

t_ServiceControl sendmail start
