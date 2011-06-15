#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Tomcat 5 Web Application Manager test."

curl -u admin:admin -s http://localhost:8080/manager/html | grep "Tomcat Web Application Manager"  >/dev/null 2>&1

t_CheckExitStatus $?
