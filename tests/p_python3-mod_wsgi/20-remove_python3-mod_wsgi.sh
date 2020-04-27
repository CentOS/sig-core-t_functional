#!/bin/bash

t_Log "Running $0 - removing python3-mod_wsgi"

if [[ $centos_ver -lt 8 ]]; then
    t_Log "python3-mod_wsgi doesn't exist before CentOS 8 -> SKIP"
    exit 0
fi

t_RemovePackage python3-mod_wsgi
