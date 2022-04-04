#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Postfix SMTP test."

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

echo "helo test" | nc -w 3 127.0.0.1 25 | grep -q '250'

t_CheckExitStatus $?
