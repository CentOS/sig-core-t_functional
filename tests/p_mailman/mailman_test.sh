#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - mailman test."

# Add mailman list
/usr/lib/mailman/bin/newlist -q mailman root@localhost.localdomain password > /dev/null 2>&1

# Restart httpd (started in other tests) and start mailman 
service httpd restart
service mailman start

curl -s http://localhost/mailman/listinfo | grep -q 'localhost Mailing Lists'

t_CheckExitStatus $?
