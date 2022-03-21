#!/bin/sh

t_Log "Running $0 - package should already be installed"

if [ "$centos_ver" -ge "8" ] ; then
 t_Log "yum is replaced by dnf on el8. SKIP"
 exit 0
fi
rpm -qa | egrep -q 'yum-.*fastestmirror'
t_CheckExitStatus $?

t_Log "Running $0 - yum should have a hard Requires on yum-plugin-fastestmirror"
rpm -q --requires yum | egrep -q 'yum-.*fastestmirror'
t_CheckExitStatus $?
