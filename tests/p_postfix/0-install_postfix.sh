#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Postfix
t_InstallPackage postfix

# Removing other MTA
t_ServiceControl sendmail stop
sleep 3
t_RemovePackage sendmail
if (t_GetPkgRel basesystem | grep -q el5)
then
  t_ServiceControl exim stop
  sleep 3
  t_RemovePackage exim
fi

t_ServiceControl postfix start
