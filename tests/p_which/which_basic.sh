#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "Running $0 - Checking which can find itself"
# which package provides /usr/bin/which and /bin/which 
# so results are depending on PATH variable
/usr/bin/which which | grep -E -q "/usr/bin/which|/bin/which"
t_CheckExitStatus $?
