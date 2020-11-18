#!/bin/bash

t_Log "Running $0 - PHP/MariaDB interaction"
t_SkipReleaseLessThan 8 'no modularity'

t_EnableModuleStream php:7.2
t_InstallPackageMinimal php-cli php-mysqlnd mariadb-server

t_Log "starting mariadb service"
systemctl --quiet start mariadb
t_CheckExitStatus $?

t_Log "create a test database"
mysql << EOF
DROP DATABASE IF EXISTS phptests;
CREATE DATABASE phptests;
USE phptests;
CREATE TABLE tests (name VARCHAR(20));
GRANT ALL ON phptests.* TO 'centos'@'localhost' IDENTIFIED BY 'qa';
FLUSH PRIVILEGES;
EOF
t_CheckExitStatus $?

t_Log "write to test database via PHP"
php << EOF &> /dev/null
<?php
\$dbconnect = mysqli_connect("localhost", "centos", "qa");
if (!\$dbconnect) {
    die('Could not connect: ' . mysqli_error());
}
mysqli_select_db(\$dbconnect, "phptests");
mysqli_query(\$dbconnect, "INSERT INTO tests (name) VALUES ('phpsqltest')");
mysqli_close(\$dbconnect);
?>
EOF
t_CheckExitStatus $?

t_Log "read from test database via PHP"
php << EOF | grep -q '1'
<?php
\$dbconnect = mysqli_connect("localhost", "centos", "qa");
if (!\$dbconnect) {
    die('Could not connect: ' . mysqli_error());
}
mysqli_select_db(\$dbconnect, "phptests");
\$array = mysqli_query(\$dbconnect, "SELECT count(*) AS success FROM tests WHERE name = 'phpsqltest'");
mysqli_close(\$dbconnect);
\$line = mysqli_fetch_array(\$array, MYSQLI_ASSOC);
print \$line['success'];
?>
EOF
t_CheckExitStatus $?

t_Log "stopping mariadb service"
systemctl --quiet stop mariadb
t_CheckExitStatus $?

t_Log "deleting database files"
find /var/lib/mysql -mindepth 1 -delete
t_CheckExitStatus $?

t_RemovePackage php-cli php-mysqlnd mariadb-server
t_ResetModule php httpd nginx mariadb
