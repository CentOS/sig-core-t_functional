#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - python can retrieve mysql-server version information."

# we need a working and running mysql server
t_InstallPackage mysql-server
t_ServiceControl mysqld start >/dev/null 2>&1

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
