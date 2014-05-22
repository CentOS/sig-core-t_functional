#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
t_Log "Running $0 - test SquirrelMail URL"

if [ "$centos_ver" -gt "5" ] ;then
  t_Log "It seems to be a CentOS $centos_ver system, this test will be disabled -> SKIP"
  exit 0
else
   curl -s http://localhost/webmail/src/login.php | grep 'SquirrelMail' > /dev/null 2>&1
fi

t_CheckExitStatus $?
