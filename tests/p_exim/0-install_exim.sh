#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

if (t_GetPkgRel basesystem | grep -q el5)
then
  t_InstallPackage exim
  # Remove other MTAs
  t_ServiceControl postfix stop
  t_ServiceControl sendmail stop
  sleep 3
  t_RemovePackage postfix exim sendmail
  t_ServiceControl exim start
else
  t_Log "This seems to be a C6 system - skipping"
fi

