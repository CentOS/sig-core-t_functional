#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd:  Welcome page has $os_name Branding."

curl -s http://localhost/ | grep "$os_name" > /dev/null 2>&1

t_CheckExitStatus $?
