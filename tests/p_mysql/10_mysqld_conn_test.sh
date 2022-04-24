#!/bin/sh

t_Log "Running $0 - mysqld client can talk to mysql server."


HostName=$(hostname -s)
MySqlHostName=$(mysql -N -B -u root -e "show variables like 'hostname'" | cut -f 2 | cut -d . -f 1)
# printing both variables for debugging purposes
echo $HostName
echo ${MySqlHostName}
if [ "$HostName" = "${MySqlHostName}" ]; then
	ret_val=0
else
	ret_val=1
fi
t_CheckExitStatus $ret_val

t_Log "Running $0 - mysqld listening test."
grep 'skip-networking' /etc/my.cnf > /dev/null
if [ $? -eq 1 ]; then
	# FIXME: Test is very basic
	>/dev/null 2>&1 >/dev/tcp/localhost/3306
	t_CheckExitStatus $?
else
	t_Log "Skipped, looks like networking is disabled for mysql"
fi
