#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage sendmail

# Remove other MTAs
t_ServiceControl postfix stop
t_ServiceControl exim stop
sleep 3
t_RemovePackage postfix exim

t_ServiceControl sendmail start
