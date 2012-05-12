#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage sendmail

# Remove other MTAs
t_ServiceControl postfix stop
sleep 3
t_RemovePackage postfix

t_ServiceControl sendmail start
