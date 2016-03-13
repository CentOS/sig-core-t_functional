#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
#	  Christoph Galuschka <tigalch@tigalch.org>
# Filename: 1_lamp_check.sh
# Version: 0.2
# Last Updated: Saturday, 09 November 2013 2:23
# Description: A simple Bash script to start LAMP daemons (httpd, mysqld), and confirm PHP is working.

# starting with 5.10, we have to differ between mysql55 and mysql

if [ "$centos_ver" = "7" ] ; then
  t_Log "no mysql55 on CentOS 7 ... SKIP"
  exit 0
fi


if [ $centos_ver = 5 ]
then
  readonly DAEMONS=( httpd mysql55-mysqld )
else
  readonly DAEMONS=( httpd mysqld )
fi
readonly DAEMONSPID=( httpd mysqld )

readonly SERVICE=/sbin/service
readonly PHP_BIN=/usr/bin/php
readonly PHP_CHECK=/tmp/check.php

# Make sure we cleanup after ourselves.
trap "/bin/rm -f $PHP_CHECK" EXIT

t_Log "Running $0 - starting LAMP daemon startup test"

# Iterate through our daemons, start each and check for the presence of each process
for D in "${DAEMONS[@]}"
do
        t_Log "Attempting startup of '$D'"

        $SERVICE $D start &>/dev/null

        t_CheckExitStatus $? "FAIL: service startup for '$D' failed ($RETVAL)"
done
for D in "${DAEMONSPID[@]}"
do

        # See if our process exists
        PIDS=$(pidof $D)

        if [ -z "$PIDS" ]; then

                t_Log "FAIL: couldn't find '$D' in the process list."
                exit $FAIL
        fi

        echo "OK"
done


# Finally, a basic check to see if PHP is working correctly.

t_Log "Performing php script check..."

cat <<EOL > $PHP_CHECK
<?php
return phpinfo();
?>
EOL

RETVAL=$PHP_BIN $PHP_CHECK &>/dev/null

if [ $RETVAL -ne 0 ]; then

        t_Log "FAIL: php_info() check failed ($RETVAL)"

fi

t_CheckExitStatus $RETVAL
