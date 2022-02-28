#!/bin/bash

t_Log "Running $0 - verify PHP API in phpinfo()"
t_SkipReleaseLessThan 8 'no modularity'

API='20170718'

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Php 7.2 module not present. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

t_EnableModuleStream php:7.2

t_InstallPackage php-cli

t_Log "Executing phpinfo()"
output=$(php -d 'date.timezone=UTC' -r 'phpinfo();')
t_CheckExitStatus $?


t_Log "Verifying PHP API matches $API"
grep -q "PHP API => $API" <<< $output
t_CheckExitStatus $?

t_RemovePackage php-cli
t_ResetModule php httpd nginx
