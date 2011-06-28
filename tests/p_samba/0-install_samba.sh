#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage samba samba-client cifs-utils

t_ServiceControl smb start
