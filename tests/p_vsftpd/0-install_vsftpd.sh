#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - installing vsFTPd."
t_InstallPackage vsftpd 
t_ServiceControl vsftpd start
