#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

echo "127.0.0.1   test" >>  /etc/hosts
cat > /etc/httpd/conf.d/vhost-test.conf <<EOF
NameVirtualHost *:80

<VirtualHost *:80>
 ServerAdmin webmaster@test
 DocumentRoot /var/www/vhosts/test/
 ServerName test
</VirtualHost>
EOF

mkdir -p /var/www/vhosts/test/
echo "Virtual Host Test Page" > /var/www/vhosts/test/index.html
service httpd restart
echo -n "HTTPD Virtual Host test:  "
echo -e "GET / HTTP/1.0\r\n" | nc test 80 | grep 'Virtual Host Test Page' > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo 'PASS'
else
	echo 'FAIL'
    exit 1
fi
