#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#         Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install procinfo"

if [ "$centos_ver" -gt "5" ] ; then
   t_Log "It seems to be a CentOS $centos_ver system, this test will be disabled -> SKIP"
   exit 0
else
   # ProcInfo Utility Package
   t_InstallPackage procinfo
fi
