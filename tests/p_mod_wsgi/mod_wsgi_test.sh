#!/bin/sh

t_Log "Running $0 - Apache httpd mod_wsgi is functional"
if [ $centos_ver -ge 6 ]
then
	while [ `ps fax | grep 'sbin/httpd' | grep -v grep  | wc -l` -gt 0 ]; do
      #t_ServiceControl httpd stop
      killall -s KILL httpd
	  sleep 1
	done

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

	t_ServiceControl httpd start
	curl -s http://localhost/tfapp | grep -q 't_functional_mod_wsgi_test'
	t_CheckExitStatus $?
	t_ServiceControl  httpd stop

else 
    echo "Skipped on CentOS 5"
fi
