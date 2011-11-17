#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christph Galuschka <christoph.galuschka@tiwag.at>

t_Log "Running $0 - very basic minicom test."

# Only checking for correct output of '-v'
# with respect to different versions on C5 and C6

if (t_GetPkgRel basesystem | grep -q el6)
then
  VERSION="2.3"
else
  VERSION="2.1"
fi

minicom -v | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
