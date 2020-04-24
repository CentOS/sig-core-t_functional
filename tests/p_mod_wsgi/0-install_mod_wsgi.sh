#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - installing mod_wsgi"

if [[ $centos_ver -lt 6 ]]; then
    t_Log "mod_wsgi doesn't exist before CentOS 6 -> SKIP"
    exit 0
fi

if [[ $centos_ver -ge 8 ]]; then
    t_InstallPackage python3-mod_wsgi
else
    t_InstallPackage mod_wsgi
fi
