#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo -n "Postfix SMTP test:  "
echo "helo test" | nc  localhost 25 | grep '250' > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
