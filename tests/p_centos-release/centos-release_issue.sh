#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/issue* has correct info test."

(grep "CentOS" /etc/issue >/dev/null 2>&1) && \
(grep "CentOS" /etc/issue.net >/dev/null 2>&1) 

t_CheckExitStatus $?
