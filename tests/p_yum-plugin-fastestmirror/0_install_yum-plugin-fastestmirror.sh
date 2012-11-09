#!/bin/sh

t_Log "Running $0 - package should already be installed"

rpm -qa | grep yum-plugin-fastestmirror > /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - yum should have a hard Requires on yum-plugin-fastestmirror"
rpm -q --requires yum | grep yum-plugin-fastestmirror > /dev/null
t_CheckExitStatus $?