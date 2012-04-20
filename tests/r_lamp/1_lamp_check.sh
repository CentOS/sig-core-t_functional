#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
# Filename: 1_lamp_check.sh
# Version: 0.1
# Last Updated: Saturday, 30 April 2011 2:23 PM AEST
# Description: A simple Bash script to start LAMP daemons (httpd, mysqld), and confirm PHP is working.

readonly DAEMONS=( httpd mysqld )

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
	
	RETVAL=$?
	
	if [ $RETVAL -ne 0 ]; then
	
		t_Log "FAIL: service startup for '$D' failed ($RETVAL)"
		exit $FAIL
		
	fi
	
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
	exit $FAIL

fi

t_CheckExitStatus $RETVAL
