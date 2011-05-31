#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo "<?php echo phpinfo(); ?>" > /var/www/html/test.php

t_Log "Running $0 - httpd handle PHP test"

curl -s http://localhost/test.php | grep 'PHP Version' > /dev/null 2>&1

t_CheckExitStatus $?
