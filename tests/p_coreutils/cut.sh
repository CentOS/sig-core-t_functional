#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test cut"

test `echo "1 2 3" | cut -f2 -d" "` -eq 2
t_CheckExitStatus $?
