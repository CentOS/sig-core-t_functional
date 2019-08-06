#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - installing Lynx"

if [ "$centos_ver" -eq "8" ]; then
  t_Log "Package lynx not available in default repos on c8 => SKIP"
  exit 0
fi

t_InstallPackage  lynx

