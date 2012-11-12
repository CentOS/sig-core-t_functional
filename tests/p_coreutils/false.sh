#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test false command"
false
test $? -eq 1
t_CheckExitStatus $?
