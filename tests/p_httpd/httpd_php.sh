#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo "<?php echo phpinfo(); ?>" > /var/www/html/test.php
echo -n "HTTPD handle PHP test:  "
echo -e "GET /test.php HTTP/1.0\r\n" | nc  localhost 80 | grep 'PHP Version' > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
