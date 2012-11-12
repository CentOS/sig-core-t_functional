#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 Check arch agrees with current running kernel"
uname -a | grep -q `arch`
t_CheckExitStatus $?
