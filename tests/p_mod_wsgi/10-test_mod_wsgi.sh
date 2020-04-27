#!/bin/bash

t_Log "Running $0 - Apache httpd mod_wsgi is functional"

if [[ $centos_ver -lt 6 || $centos_ver -gt 7 ]]; then
    t_Log "mod_wsgi not available before CentOS 6 or after CentOS 7 -> SKIP"
    exit 0
fi

cat > /etc/httpd/conf.d/tfapp.conf << EOF
WSGIScriptAlias /tfapp /var/www/html/tfapp.wsgi
EOF

cat > /var/www/html/tfapp.wsgi << EOF
def application(environ, start_response):
    status = '200 OK'
    output = 't_functional_mod_wsgi_test'.encode()
    response_headers = [
        ('Content-type', 'text/plain'),
        ('Content-Length', str(len(output)))
    ]
    start_response(status, response_headers)
    return [output]
EOF

if [[ $centos_ver -ge 7 ]]; then
    systemctl restart httpd
else
    service httpd restart
fi

curl -s http://localhost/tfapp | grep -q 't_functional_mod_wsgi_test'
t_CheckExitStatus $?

if [[ $centos_ver -ge 7 ]]; then
    systemctl stop httpd
else
    service httpd stop
fi

rm /etc/httpd/conf.d/tfapp.conf /var/www/html/tfapp.wsgi
