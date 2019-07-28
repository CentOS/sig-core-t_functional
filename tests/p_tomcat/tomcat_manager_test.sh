#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
if [ "$centos_ver" -ge "8" ] ; then
   exit 0
fi
#uname_arch=$(uname -m)
#if [ "$uname_arch" == "i686" ] ; then
#t_Log "Skipping $0 on $uname_arch"
#exit 0
#else
t_Log "Running $0 - Tomcat Web Application Manager test."
#fi
curl -u admin:admin -s http://localhost:8080/manager/html | grep "Tomcat Web Application Manager"  >/dev/null 2>&1

t_CheckExitStatus $?
