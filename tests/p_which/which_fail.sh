#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "Running $0 - Checking which can fails on non-existing commands"
which abc123 2> /dev/null
[ $? -eq 1 ] || { t_Log "Which should have exited with 1 for a non-existing file"; exit $FAIL; }
t_CheckExitStatus $?
