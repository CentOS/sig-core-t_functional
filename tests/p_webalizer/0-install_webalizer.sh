#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage webalizer 
t_ServiceControl httpd reload
