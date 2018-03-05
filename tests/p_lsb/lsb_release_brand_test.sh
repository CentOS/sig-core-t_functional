#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - LSB CentOS braning check."

uname_arch=$(uname -m)

if [ "$uname_arch" == "armv7l" ]; then
  t_Log "*** Not testing on Arch: $uname_arch ***"
  exit 0
fi

lsb_release -i | grep -q "CentOS" && \
lsb_release -d | grep -q "CentOS"  

t_CheckExitStatus $?
