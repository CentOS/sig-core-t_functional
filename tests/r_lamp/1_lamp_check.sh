#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
#	  Christoph Galuschka <tigalch@tigalch.org>
# Filename: 1_lamp_check.sh
# Version: 0.2
# Last Updated: Saturday, 09 November 2013 2:23
# Description: A simple Bash script to start LAMP daemons (httpd, mysqld), and confirm PHP is working.

if [ "$centos_ver" -ge "7" ] ; then
  readonly DAEMONS=( httpd mariadb )
else
 readonly DAEMONS=( httpd mysqld )
fi

readonly SERVICE=/sbin/service
readonly PHP_BIN=/usr/bin/php
readonly PHP_CHECK=/tmp/check.php

# Make sure we cleanup after ourselves.
trap "/bin/rm -f $PHP_CHECK" EXIT

t_Log "Running $0 - starting LAMP daemon startup test"

# Iterate through our daemons, start each and check for the presence of each process
for D in "${DAEMONS[@]}"
do
  t_ServiceControl $D restart
done

# Finally, a basic check to see if PHP is working correctly.

t_Log "Performing php script check..."

cat <<EOL > $PHP_CHECK
<?php
return phpinfo();
?>
EOL

$PHP_BIN $PHP_CHECK &>/dev/null
RETVAL="$?"

if [ "$RETVAL" -ne "0" ]; then

        t_Log "FAIL: php_info() check failed ($RETVAL)"

fi

t_CheckExitStatus $RETVAL
