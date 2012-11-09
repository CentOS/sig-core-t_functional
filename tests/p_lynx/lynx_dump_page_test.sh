#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that lynx can dump remote page."

if [ $SKIP_QA_HARNESS -eq 1 ]; then
  HOST=wiki.centos.org
  CHECK_FOR="Page templates"
else
  HOST=repo.centos.qa
  CHECK_FOR="ks_cfg"
fi

lynx -dump http://${HOST}/qa/ | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
