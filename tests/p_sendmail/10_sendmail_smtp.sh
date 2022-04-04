#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - Sendmail SMTP test."

echo "helo test" | nc -4 -w 3 localhost 25 | grep -q '250'

t_CheckExitStatus $?
