#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - installing Tomcat 5"
t_InstallPackage  tomcat5 tomcat5-admin-webapps tomcat5-webapps
service tomcat5 start
