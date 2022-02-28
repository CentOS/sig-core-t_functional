#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - python can retrieve mysql-server version information."

if [ "$centos_ver" -ge 8 ] ; then
PYTHON=python3
else
PYTHON=python
fi
# we need a working and running mysql server
# starting with 5.10, we have to differ between mysql55 and mysql

if [ "$centos_ver" -ge 7 ] ; then
  my_packages="mariadb mariadb-server nc"
  mysql_service="mariadb"
elif [ "$centos_ver" = "5" ] ;then
  my_packages="mysql mysql-server nc mysql55-mysql-server"
  mysql_service="mysqld"
else
  my_packages="mysql mysql-server nc"
  mysql_service="mysqld"
fi

t_InstallPackage ${my_packages}
t_ServiceControl ${mysql_service} start >/dev/null 2>&1

# Installing additional python/mysql module
if [ "$centos_ver" -ge 8 ] ; then
t_InstallPackage python3-PyMySQL
importcomponent="pymysql"
else
t_InstallPackage MySQL-python
importcomponent="MySQLdb"
fi

# create python Scrip
SCRIPT='/var/tmp/test.py'

cat >$SCRIPT <<EOF
import $importcomponent

conn = $importcomponent.connect (unix_socket="/var/lib/mysql/mysql.sock",
                           user = "",
                           passwd = "",
                           db = "")
cursor = conn.cursor ()
cursor.execute ("SELECT VERSION()")
row = cursor.fetchone ()
print ("server version:", row[0])
cursor.close ()
conn.close ()
EOF

# If we execute the script and get the version it works
$PYTHON $SCRIPT |grep -q 'server version'

t_CheckExitStatus $?

# cleaning up
/bin/rm $SCRIPT
