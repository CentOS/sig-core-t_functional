#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

if [ "$centos_ver" -ge 8 ] ; then
  exit 0
fi
# Start NTPd services and confirm it's running.
t_ServiceControl ntpd start

NTPD_PID=$(pidof ntpd)

[ "$NTPD_PID" ] || { t_Log "FAIL: couldn't find 'ntpd' in the process list."; exit $FAIL; }
