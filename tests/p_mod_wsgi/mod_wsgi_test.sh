#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Apache httpd mod_wsgi is functional"
if (t_GetPkgRel basesystem | grep -q el6)
then


cat > /etc/httpd/conf.d/tf_app.conf <<EOF
WSGIScriptAlias /tfapp /var/www/html/tf_app.wsgi
EOF

cat > /var/www/html/tf_app.wsgi <<EOF

def application(environ, start_response):
    status = '200 OK'
    output = 't_functional_mod_wsgi_test'

    response_headers = [('Content-type', 'text/plain'),
                        ('Content-Length', str(len(output)))]
    start_response(status, response_headers)

    return [output]
EOF

t_ServiceControl httpd reload


curl -s http://localhost/tfapp | grep -q 't_functional_mod_wsgi_test'

t_CheckExitStatus $?

else 
    echo "Skipped on CentOS 5"
fi
