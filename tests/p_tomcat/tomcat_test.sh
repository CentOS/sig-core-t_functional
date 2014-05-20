#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Tomcat basic test."

if [ "$centos_ver" = "7" ] ; then
 string_tosearch="you've successfully installed Tomcat. Congratulations!"
else
 string_tosearch="you've setup Tomcat successfully. Congratulations!"
fi

curl -s http://localhost:8080/ | grep "${string_tosearch}"  >/dev/null 2>&1

t_CheckExitStatus $?
