#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - LSB CentOS branding check."

lsb_release -i | grep -q "CentOS" && \
lsb_release -d | grep -q "CentOS"

t_CheckExitStatus $?
