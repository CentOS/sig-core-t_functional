#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - Configuring Tomcat 5"

sed -i 's/<\/tomcat-users>/<user username="admin" password="admin" roles="admin,manager"\/>\n<\/tomcat-users>/' /etc/tomcat5/tomcat-users.xml 


service tomcat5 restart
