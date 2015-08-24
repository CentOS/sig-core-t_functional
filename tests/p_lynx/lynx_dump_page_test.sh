#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that lynx can dump remote page."

if [ "$SKIP_QA_HARNESS" = "1" ] ; then
  URL="http://mirror.centos.org/"
  CHECK_FOR="CentOS on the Web"
else
  URL="http://repo.centos.qa/qa/"
  CHECK_FOR="ks_cfg"
fi

lynx -dump ${URL} | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
