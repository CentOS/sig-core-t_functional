#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - test SquirrelMail URL."
echo -e "GET /webmail/src/login.php HTTP/1.0\r\n" | nc localhost 80 | grep 'SquirrelMail' > /dev/null 2>&1
t_CheckExitStatus $?
