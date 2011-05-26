#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd serve html page test."

echo -e "GET / HTTP/1.0\r\n" | nc  localhost 80 | grep 'Test Page'

t_CheckExitStatus $?
