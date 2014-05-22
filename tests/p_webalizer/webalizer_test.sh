#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Webalizer test."

if [ "$centos_ver" = "7" ] ; then
 t_Log "No webalizer package for CentOS $centos_ver -> SKIP"
 t_CheckExitStatus 0
 exit 0
fi

# Run some requests 
for i in `seq 10`
do
    curl http://localhost/ > /dev/null 2>&1
done

# Trigger webalizer cron manualy
/etc/cron.daily/00webalizer

# Run the test
curl -s http://localhost/usage/ | grep 'Usage Statistics for' > /dev/null 2>&1

t_CheckExitStatus $?
