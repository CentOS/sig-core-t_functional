#!/bin/bash

if [ "$centos_ver" -ge 8 ] ; then
PYTHON=python3
else
PYTHON=python
fi

t_Log "Running $0 - Testing audit2why for policy mismatch ..."

cat << __EOF__ | $PYTHON -
import sys
import selinux.audit2why as audit2why

try:
  audit2why.init()
except:
  sys.exit(1)
sys.exit(0)
__EOF__

t_CheckExitStatus $?
