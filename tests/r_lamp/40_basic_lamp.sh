#!/bin/bash

t_Log "Running $0 - install a minimal lamp stack, and test it"

t_InstallPackage httpd mysql mysql-server php php-mysql wget
t_ServiceControl mysqld start
t_ServiceControl httpd start

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
	t_Log PASS;
	exit 0;
else
	t_Log FAIL;
	exit 1;
fi
