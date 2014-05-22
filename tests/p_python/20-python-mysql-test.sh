#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - python can retrieve mysql-server version information."

# we need a working and running mysql server
# starting with 5.10, we have to differ between mysql55 and mysql

if [ "$centos_ver" = "7" ] ; then
  my_packages="mariadb mariadb-server nc"
  mysql_service="mariadb"
elif [ "$centos_ver" = "5" ] ;then
  my_packages="mysql mysql-server nc mysql55-mysql-server"
  mysql_service="mysqld"
else
  my_packages="mysql mysql-server nc"
  mysql_service="mysqld"
fi

t_ServiceControl ${mysql_service} start >/dev/null 2>&1

# Installing additional python/mysql module
t_InstallPackage MySQL-python

# create python Scrip
SCRIPT='/var/tmp/test.py'

cat >$SCRIPT <<EOF
import MySQLdb

conn = MySQLdb.connect (host = "localhost",
                           user = "",
                           passwd = "",
                           db = "test")
cursor = conn.cursor ()
cursor.execute ("SELECT VERSION()")
row = cursor.fetchone ()
print "server version:", row[0]
cursor.close ()
conn.close ()
EOF

# If we execute the script and get the version it works
python $SCRIPT |grep -q 'server version'

t_CheckExitStatus $?

# cleaning up
/bin/rm $SCRIPT
