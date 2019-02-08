#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

uname_arch=$(uname -m)
if [ "$uname_arch" == "i686" ] ; then
t_Log "Skipping $0 on $uname_arch"
exit 0
else
t_Log "Running $0 - Tomcat basic test."
fi

if [ "$centos_ver" = "7" ] ; then
 string_tosearch="you've successfully installed Tomcat. Congratulations!"
else
 string_tosearch="you've setup Tomcat successfully. Congratulations!"
fi

curl -s http://localhost:8080/ | grep "${string_tosearch}"  >/dev/null 2>&1

t_CheckExitStatus $?
