#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 - test various user commands from coreutils"
who | grep -q "$LOGNAME" && who mom likes | grep -q "$LOGNAME" && users | grep -q "$LOGNAME" && id | grep -q "$LOGNAME" && logname | grep -q "$LOGNAME"
t_CheckExitStatus $?
