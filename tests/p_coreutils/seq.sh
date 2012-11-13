#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0"
seq -s " " 5 | grep -q "1 2 3 4 5" && seq -s " " 6 8 | grep -q "6 7 8" && seq -s " " 8 2 12 | grep -q "8 10 12"
t_CheckExitStatus $?
