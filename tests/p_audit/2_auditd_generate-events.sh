#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  Generate some events for audit log."

useradd testauditd
userdel testauditd

t_CheckExitStatus $?
