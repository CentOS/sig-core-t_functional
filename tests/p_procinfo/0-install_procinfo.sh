#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#         Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install procinfo"

if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log "It seems to be a CentOS 6.x system, this test will be disabled"
   exit 0
else
   # ProcInfo Utility Package
   t_InstallPackage procinfo
fi
