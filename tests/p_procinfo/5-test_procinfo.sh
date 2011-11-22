#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#         Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log It seems to be a CentOS 6.x system, this test will be disabled
   exit 0
else
    t_Log "Running $0 - checking procinfo runs and returns non-zero exit status."

    PROCINFO=`which procinfo`

    $PROCINFO &>/dev/null

    t_CheckExitStatus $?

fi
