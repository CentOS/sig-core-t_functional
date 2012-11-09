#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#         Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking procinfo runs and returns non-zero exit status."

if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log "It seems to be a CentOS 6.x system, this test will be disabled"
   exit 0
else
    if [ $SKIP_QA_HARNESS  -eq 1 ]; then
      t_Log "Skip, seems to fail on CI ..."
    else

      PROCINFO=`which procinfo`

      $PROCINFO &>/dev/null

      t_CheckExitStatus $?
    fi
fi
