#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el5)
then
    t_InstallPackage mod_python
    service httpd restart
else 
    echo "Skipped on CentOS 6"
fi


