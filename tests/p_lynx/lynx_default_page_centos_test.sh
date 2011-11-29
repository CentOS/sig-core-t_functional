#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that lynx default page is CentOS welcome page ."

lynx -dump  | grep "Welcome to CentOS"  >/dev/null 2>&1

t_CheckExitStatus $?
