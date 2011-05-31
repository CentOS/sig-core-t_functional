#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - test SquirrelMail URL."
curl -s http://localhost/webmail/src/login.php | grep 'SquirrelMail' > /dev/null 2>&1
t_CheckExitStatus $?
