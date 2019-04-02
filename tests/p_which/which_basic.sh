#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "Running $0 - Checking which can find itself"
/usr/bin/which which | grep -E -q '^(/usr)?/bin/which$'
t_CheckExitStatus $?
