#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Remove other MTAs
t_ServiceControl sendmail stop
t_ServiceControl exim stop
sleep 3
t_RemovePackage sendmail
t_RemovePackage exim

# Postfix
t_InstallPackage postfix
t_ServiceControl postfix start
