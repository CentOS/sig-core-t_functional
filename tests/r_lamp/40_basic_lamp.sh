#!/bin/bash

t_Log "Running $0 - install a minimal lamp stack, and test it"

# MySQL
# starting with 5.10, we have to differ between mysql55 and mysql
if [ $centos_ver = 5 ]
then
  t_InstallPackage mysql55-mysql-server httpd mysql55-mysql php php-mysql wget
  t_ServiceControl mysql55-mysqld restart
else
  t_InstallPackage httpd mysql mysql-server php php-mysql wget
  t_ServiceControl mysqld restart
fi
t_ServiceControl httpd restart

# Initializing a small MySQL db
cat >/tmp/mysql-QA.sql <<EOF
create database qatests;
use qatests;
create table tests (name varchar(20)) ;
grant all on qatests.* to 'centos'@'localhost' identified by 'qa';
flush privileges;
EOF

mysql </tmp/mysql-QA.sql
/bin/rm /tmp/mysql-QA.sql

# Creating a simple php query page to insert Data in the MySQL DB

cat >/var/www/html/mysql.php <<EOF
<?php
\$dbconnect = mysql_connect("localhost","centos","qa");
if (!\$dbconnect)
  {
  die('Could not connect: ' . mysql_error());
  }

mysql_select_db("qatests", \$dbconnect);

mysql_query("INSERT INTO tests (name)
VALUES ('mysqltest')");

mysql_close(\$dbconnect);
?> 
EOF

####################################################
# testing
####################################################

curl -s  http://localhost/mysql.php 

t_Log "Performing basic LAMP test"
content=`echo "select * from qatests.tests where name='mysqltest'"|mysql -B --skip-column-names`

# Clean up
mysql -u root -e 'drop database qatests;'
service httpd stop

if [ "$content" = "mysqltest" ] ; then
	ret_val=0;
else
	ret_val=1;
fi

t_CheckExitStatus $ret_val
