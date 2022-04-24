#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ $SKIP_QA_HARNESS -eq 1 -o $CONTAINERTEST -eq 1 ]; then
	    echo "Skipping this test ..."
else
t_Log "Running $0 -  Generate some events for audit log."

useradd testauditd
userdel testauditd

t_CheckExitStatus $?
fi
