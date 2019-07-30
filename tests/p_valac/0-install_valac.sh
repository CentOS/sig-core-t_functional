#!/bin/bash
# Author: Lz <lz843723683@163.com>

if [ "$centos_ver" -ne "7" ];then
	t_Log "Package not included in CentOS $centos_ver => SKIP"
	exit 0
fi

t_Log "$0 - installing valac"
t_InstallPackage vala

