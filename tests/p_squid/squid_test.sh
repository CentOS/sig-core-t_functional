#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Squid test."

if [ $SKIP_QA_HARNESS ]; then
  HOST=wiki.centos.org
  CHECK_FOR="Page templates"
else
  HOST=qa.centos.repo
  CHECK_FOR="ks_cfg"
fi

squidclient -T 2 http://${HOST}/qa/ | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
