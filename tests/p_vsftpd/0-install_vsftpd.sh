#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# vsFTPd
t_InstallPackage vsftpd 
chkconfig vsftpd on
t_ServiceControl vsftpd start
