#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - Exim SMTP test."

if (t_GetPkgRel basesystem | grep -q el5)
then
  echo "helo test" | nc -w 3 localhost 25 | grep -q '250'
  ret_val=$?
else
  t_Log "This seems to be A C6 system - skipping"
  ret_val=0
fi

t_CheckExitStatus $?
