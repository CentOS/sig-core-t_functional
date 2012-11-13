#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 - test various user commands from coreutils"
who
echo $?
who | grep -q "$LOGNAME" && who mom likes
echo $?
who | grep -q "$LOGNAME" && who mom likes | grep -q "$LOGNAME" && users
echo $?
who | grep -q "$LOGNAME" && who mom likes | grep -q "$LOGNAME" && users | grep -q "$LOGNAME" && id
echo $?
who | grep -q "$LOGNAME" && who mom likes | grep -q "$LOGNAME" && users | grep -q "$LOGNAME" && id | grep -q "$LOGNAME" && logname
echo $?
who | grep -q "$LOGNAME" && who mom likes | grep -q "$LOGNAME" && users | grep -q "$LOGNAME" && id | grep -q "$LOGNAME" && logname | grep -q "$LOGNAME"

t_CheckExitStatus $?
