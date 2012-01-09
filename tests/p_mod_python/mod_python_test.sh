#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Apache httpd mod_python is functional"
if (t_GetPkgRel basesystem | grep -q el5)
then


cat > /etc/httpd/conf.d/tf_mptest.conf <<EOF
<Directory /var/www/html/mptest> 
    AddHandler mod_python .py
    PythonHandler mptest 
    PythonDebug On 
</Directory>
EOF

mkdir -p /var/www/html/mptest/

cat > /var/www/html/mptest/mptest.py <<EOF
from mod_python import apache

def handler(req):
    req.content_type = 'text/plain'
    req.write("t_functional_mod_python_test")
    return apache.OK
EOF

t_ServiceControl httpd reload


curl -s http://localhost/mptest/mptest.py | grep -q 't_functional_mod_python_test'

t_CheckExitStatus $?

else 
    echo "Skipped on CentOS 6"
fi
