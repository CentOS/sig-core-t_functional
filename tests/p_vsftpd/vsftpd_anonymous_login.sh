#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - vsFTPd anonymous can login test."

echo -e "user anonymous\npass password\nquit" | nc localhost 21 | grep -q "230 Login successful."

t_CheckExitStatus $?
