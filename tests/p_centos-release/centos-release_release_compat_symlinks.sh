#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/$vendor-release compatibility symbolic links test."

if [ "$centos_ver" -ge 6 ]
then
  grep $os_name /etc/$vendor-release >/dev/null 2>&1
  (file /etc/redhat-release | grep -E "symbolic link to .?$vendor-release.?"  >/dev/null 2>&1) &&\
  (file /etc/system-release | grep -E "symbolic link to .?$vendor-release.?"  >/dev/null 2>&1)
else
   echo "This test is not comptatible with CentOS <= 5"
fi

t_CheckExitStatus $?
