#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Squid test."

if [ $SKIP_QA_HARNESS -eq 1 ]; then
  URL="http://mirror.centos.org/"
  CHECK_FOR="timestamp"
else
  URL="http://repo.centos.qa/qa/"
  CHECK_FOR="ks_cfg"
fi

squidclient -T 2 ${URL} | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
