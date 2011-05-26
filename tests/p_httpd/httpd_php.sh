#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo "<?php echo phpinfo(); ?>" > /var/www/html/test.php

t_Log "Running $0 - httpd handle PHP test"

echo -e "GET /test.php HTTP/1.0\r\n" | nc  localhost 80 | grep 'PHP Version'

t_CheckExitStatus $?
