#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd: $os_name branding / Server tokens value "

curl -sI http://localhost/ | grep -i "Server:\ Apache.*\ ($os_name" > /dev/null 2>&1

t_CheckExitStatus $?
