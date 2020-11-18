#!/bin/bash

t_Log "Running $0 - verify PHP API in phpinfo()"
t_SkipReleaseLessThan 8 'no modularity'

t_EnableModuleStream php:7.2
t_InstallPackage php-cli

t_Log "Executing phpinfo()"
output=$(php -d 'date.timezone=UTC' -r 'phpinfo();')
t_CheckExitStatus $?

API='20170718'

t_Log "Verifying PHP API matches $API"
grep -q "PHP API => $API" <<< $output
t_CheckExitStatus $?

t_RemovePackage php-cli
t_ResetModule php httpd nginx
