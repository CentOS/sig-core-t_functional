#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Note: This was a known issue in CentOS 6.0
# See: http://bugs.centos.org/view.php?id=5158

t_Log "Running $0 -  check that bash version info is the same with upstream."

bash --version | grep -qE "(i386|i686|x86_64)-redhat-linux-gnu"

t_CheckExitStatus $?
