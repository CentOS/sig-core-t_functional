#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <tigalch@tigalch.org>
# reusing the script from LAMP-Tests

t_Log "Running $0 - php-cli basic interaction with mysql test."

# Install php-mysql/php-mysqld module depending on version
# we need a working and running mysql server
#starting with 5.10 we need to reflect mysql55
if [ $centos_ver = 5 ]
then
  t_InstallPackage mysql-server mysql55-mysql-server nc php-mysql
  t_ServiceControl mysql55-mysqld stop
  t_ServiceControl mysqld start >/dev/null 2>&1
elif [ $centos_ver = 6 ]
then
  t_InstallPackage mysql-server nc php-mysql
  t_ServiceControl mysqld start >/dev/null 2>&1
else
  t_InstallPackage mariadb-server nc php-mysqlnd
  t_ServiceControl mariadb start >/dev/null 2>&1
fi

#create a little DB to use
CREATE='/var/tmp/mysql-php-QA.sql'

cat >$CREATE <<EOF
drop database if exists phptests;
create database phptests;
use phptests;
create table tests (name varchar(20)) ;
grant all on phptests.* to 'centos'@'localhost' identified by 'qa';
flush privileges;
EOF

mysql <$CREATE

# create PHP Script and write something into DB
INSERT='/var/tmp/test.php'

cat >$INSERT <<EOF
<?php
\$dbconnect = mysqli_connect("localhost","centos","qa");
if (!\$dbconnect)
  {
  die('Could not connect: ' . mysqli_error());
  }
mysqli_select_db(\$dbconnect, "phptests");
mysqli_query(\$dbconnect, "INSERT INTO tests (name)
VALUES ('phpsqltest')");
mysqli_close(\$dbconnect);
?> 
EOF

php $INSERT
if [ $? -ne 0 ]
  then
  t_Log "Inserting into DB failed"
  exit 1
fi

# create PHP script to read from DB
READ='/var/tmp/read.php'
cat >$READ <<EOF
<?php
\$dbconnect = mysqli_connect("localhost","centos","qa");
if (!\$dbconnect)
  {
  die('Could not connect: ' . mysqli_error());
  }
mysqli_select_db(\$dbconnect, "phptests");
\$array = mysqli_query(\$dbconnect, "SELECT count(*) as success FROM tests WHERE name = 'phpsqltest'");
mysqli_close(\$dbconnect);
\$line = mysqli_fetch_array(\$array, MYSQLI_ASSOC);
print \$line['success'];
?>
EOF

# If we execute the script and get '1' it works (1 entry should be in the DB)
php $READ | grep -q '1'

t_CheckExitStatus $?

#cleaning up
/bin/rm $READ $CREATE $INSERT
mysql -u root -e 'drop database phptests' >/dev/null 2>&1
