#!/bin/bash

# purpose : install a minimal lamp stack, and test it

# Installing required bits

yum install -y httpd mysql mysql-server php php-mysql wget > /dev/null 2>&1
service mysqld start
service httpd start

# Initializing a small MySQL db
cat >>/tmp/mysql-QA.sql <<EOF
create database qatests;
use qatests;
create table tests (name varchar(20)) ;
grant all on qatests.* to 'centos'@'localhost' identified by 'qa';
flush privileges;
EOF

mysql </tmp/mysql-QA.sql
/bin/rm /tmp/mysql-QA.sql

# Creating a simple php query page to insert Data in the MySQL DB

cat >>/var/www/html/mysql.php <<EOF
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

wget http://localhost/mysql.php

echo "Basic LAMP test ..."
content=`echo "select * from qatests.tests where name='mysqltest'"|mysql -B --skip-column-names`
if [ "$content" = "mysqltest" ] ; then
	echo PASS;
	exit 0;
else
	echo Fail;
	exit 1;
fi
