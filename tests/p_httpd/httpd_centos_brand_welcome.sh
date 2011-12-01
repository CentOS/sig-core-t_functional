#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd:  Welcome page has CentOS Branding."

curl -s http://localhost/ | grep 'CentOS' > /dev/null 2>&1

t_CheckExitStatus $?
