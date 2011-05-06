#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo -n "HTTPD serve html page test:  "
echo -e "GET / HTTP/1.0\r\n" | nc  localhost 80 | grep 'Test Page' > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
