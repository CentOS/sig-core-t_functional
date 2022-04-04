#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - vsFTPd anonymous can login test."

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

echo -e "user anonymous\npass password\nquit" | nc localhost 21 | grep -q "230 Login successful."

t_CheckExitStatus $?
