#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage webalizer 
t_InstallPackage httpd
t_ServiceControl httpd restart
