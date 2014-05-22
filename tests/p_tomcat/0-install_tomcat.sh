#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$centos_ver" = "7" ] ;then
 tomcat_packages="tomcat tomcat-admin-webapps tomcat-webapps"
elif [ "$centos_ver" = "6" ]; then
 tomcat_packages="tomcat6 tomcat6-admin-webapps tomcat6-webapps"
else
 tomcat_packages="tomcat5 tomcat5-admin-webapps tomcat5-webapps"
fi

t_Log "$0 - installing Tomcat packages"
t_InstallPackage  ${tomcat_packages}
