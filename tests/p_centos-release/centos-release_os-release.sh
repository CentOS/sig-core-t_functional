#!/bin/bash
# Author: Fabian Arrotin <arrfab@centos.org>

t_Log "Running $0 - /etc/os-release has correct ABRT string for $os_name $centos_ver"

if [[ $is_almalinux == "yes" ]]; then
	lines_to_check="ALMALINUX_MANTISBT_PROJECT=\"AlmaLinux-$centos_ver\" ALMALINUX_MANTISBT_PROJECT_VERSION=\"$centos_ver.$minor_ver\""
else
	lines_to_check="CENTOS_MANTISBT_PROJECT=\"CentOS-$centos_ver\" CENTOS_MANTISBT_PROJECT_VERSION=\"$centos_ver\""
fi

if [ "$centos_ver" -ge 7 ];then
	if [[ $centos_stream == "no" ]]; then
	  for string in $lines_to_check
	  do 
	    grep -q $string /etc/os-release
	    if [ $? -ne "0" ];then
	      t_Log "missing string $string in os-release file !"
	      exit 1
	    fi
	  done  
	else
	  echo "Skipping for CentOS Stream" ; exit 0
	fi

	if [ "$centos_ver" -eq 7 ]; then
	  for string in REDHAT_SUPPORT_PRODUCT=\"centos\" REDHAT_SUPPORT_PRODUCT_VERSION=\"$centos_ver\"
	  do 
	    grep -q $string /etc/os-release
	    if [ $? -ne "0" ];then
	      t_Log "missing string $string in os-release file !"
	      exit 1
	    fi
	  done  
	fi
else
  echo "Skipping for CentOS 5 and 6 ..." ; exit 0	
fi

t_CheckExitStatus $?

