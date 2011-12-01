#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd: basic authentication"

cat > /etc/httpd/conf.d/dir-test-basic-auth.conf <<EOF
Alias /basic_auth_test /var/www/html/basic_auth_test
<Directory "/var/www/html/basic_auth_test">
  AuthType Basic
  AuthName "Test"
  AuthUserFile /etc/httpd/htpasswd
  require user test
</Directory>
EOF

htpasswd -c -b /etc/httpd/htpasswd test test
mkdir -p /var/www/html/basic_auth_test
echo "Basic authentication Test Page" > /var/www/html/basic_auth_test/index.html
t_ServiceControl httpd reload
curl -s -u test:test http://localhost/basic_auth_test/ | grep 'Basic authentication Test Page' > /dev/null 2>&1

t_CheckExitStatus $?
