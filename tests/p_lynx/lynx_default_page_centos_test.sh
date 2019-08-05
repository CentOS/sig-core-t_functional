#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that lynx default page is CentOS welcome page ."

if [ "$centos_ver" -eq "8" ]; then
  t_Log "Package lynx not available in default repos on c8 => SKIP"
  exit 0
fi


lynx -dump  | grep "Welcome to CentOS"  >/dev/null 2>&1

t_CheckExitStatus $?
