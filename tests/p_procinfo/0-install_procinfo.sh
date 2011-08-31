#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#         Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log It seems to be a CentOS 6.x system, this test will be disabled
   exit 0
else
   # ProcInfo Utility Package
   t_InstallPackage procinfo
fi
