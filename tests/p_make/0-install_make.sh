#!/bin/bash
# Author: Lz <lz843723683@163.com>

if [ "$centos_ver" -ge "8" ];then
	t_Log "Package  not included in CentOS $centos_ver => SKIP"
	exit 0
fi

t_Log "$0 - installing gcc make"
t_InstallPackage gcc make

