#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - Configuring Tomcat"

if (t_GetPkgRel basesystem | grep -q el6)
then
   TOMCAT_SRV_NAME=tomcat6
   TOMCAT_CONF_DIR=/etc/tomcat6/
else
   TOMCAT_SRV_NAME=tomcat5
   TOMCAT_CONF_DIR=/etc/tomcat5/
fi

sed -i 's/<\/tomcat-users>/<user username="admin" password="admin" roles="admin,manager"\/>\n<\/tomcat-users>/' $TOMCAT_CONF_DIR/tomcat-users.xml 


service $TOMCAT_SRV_NAME restart

# we need extra sec for tomcat
sleep 5
