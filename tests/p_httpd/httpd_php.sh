#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd: can parse a phpinfo/PHP page"

echo "<?php echo phpinfo(); ?>" > /var/www/html/test.php

curl -s http://localhost/test.php | grep 'PHP Version' > /dev/null 2>&1

t_CheckExitStatus $?
