#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that lynx can dump remote page."

if [ "$centos_ver" -eq "8" ]; then
  t_Log "Package lynx not available in default repos on c8 => SKIP"
  exit 0
fi


if [ "$SKIP_QA_HARNESS" = "1" ] ; then
  URL="http://mirror.centos.org/"
  CHECK_FOR="CentOS on the Web"
else
  URL="http://repo.centos.qa/qa/"
  CHECK_FOR="ks_cfg"
fi

lynx -dump ${URL} | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
