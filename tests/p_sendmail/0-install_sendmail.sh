#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - remove unused MTAs and install sendmail"

t_InstallPackage sendmail nc

# Remove other MTAs
t_ServiceControl postfix stop
t_ServiceControl exim stop
sleep 3
t_RemovePackage postfix exim

t_ServiceControl sendmail start
