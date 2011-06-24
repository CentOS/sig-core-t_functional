#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage sendmail

# Remove other MTAs
t_RemovePackage postfix exim
t_ServiceControl postfix stop
t_ServiceControl exim stop

t_ServiceControl sendmail start
