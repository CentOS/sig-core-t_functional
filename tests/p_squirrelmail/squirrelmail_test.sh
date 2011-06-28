#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
if (t_GetPkgRel basesystem | grep -q el6)
then
   t_Log It seems to be a CentOS 6.x system, this test will be disabled
else
   t_Log "Running $0 - test SquirrelMail URL."
   curl -s http://localhost/webmail/src/login.php | grep 'SquirrelMail' > /dev/null 2>&1
fi

t_CheckExitStatus $?
