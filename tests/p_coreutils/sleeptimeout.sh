#!/bin/bash
# Author Alice Kaerast <alice@kaerast.info>

t_Log "$0 checking timeout and sleep"

timeout 1 sleep 2
test $? -eq 124 && timeout 2 sleep 1
t_CheckExitStatus $?
