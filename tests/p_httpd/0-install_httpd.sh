#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# HTTPD / PHP 
yum -y install httpd mod_ssl php php-mysql 
chkconfig httpd on
service httpd start
