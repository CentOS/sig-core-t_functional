#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Postfix SMTP test."

echo "helo test" | nc  localhost 25 | grep '250' > /dev/null 2>&1

t_CheckExitStatus $?