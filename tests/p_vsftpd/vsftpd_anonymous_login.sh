#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - vsFTPd anonymous can login test."

echo -e "user anonymous\npass password\nquit" | nc localhost 21 | grep "230 Login successful." > /dev/null 2>&1

t_CheckExitStatus $?