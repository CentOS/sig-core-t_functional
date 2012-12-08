#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - remove unused MTAs and install exim"

if (t_GetPkgRel basesystem | grep -q el5)
then
  t_InstallPackage exim expect
  # Remove other MTAs
  t_ServiceControl postfix stop
  t_ServiceControl sendmail stop
  sleep 3
  t_RemovePackage postfix sendmail
  # Fix exim.conf to not use IPv6
  sed -i 's/\:\:1//' /etc/exim/exim.conf
  t_ServiceControl exim start
else
  t_Log "This seems to be a C6 system - skipping"
fi

