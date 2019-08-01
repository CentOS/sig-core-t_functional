#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd: serve html page"

curl -H 'Accept-Language: en' -s http://localhost/ | grep 'Test Page' > /dev/null 2>&1

t_CheckExitStatus $?
