#!/bin/bash
# Author: Fabian Arrotin <arrfab@centos.org>

t_Log "Running $0 - /etc/os-release has correct ABRT string for CentOS 7"

if [ "$centos_ver" = "7" ];then
  for string in CENTOS_MANTISBT_PROJECT=\"CentOS-7\" CENTOS_MANTISBT_PROJECT_VERSION=\"7\" REDHAT_SUPPORT_PRODUCT=\"centos\" REDHAT_SUPPORT_PRODUCT_VERSION=\"7\" 
  do 
    grep -q $string /etc/os-release
    if [ $? -ne "0" ];then
      t_Log "missing string $string in os-release file !"
      exit 1
    fi
  done  
else
  echo "Skipping for CentOS 5 and 6 ..." ; exit 0
fi

t_CheckExitStatus $?

