#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Tomcat 5 basic test."

curl -s http://localhost:8080/ | grep "you've setup Tomcat successfully. Congratulations!"  >/dev/null 2>&1

t_CheckExitStatus $?
