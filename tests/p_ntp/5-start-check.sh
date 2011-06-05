#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# Start NTPd services and confirm it's running.
chkconfig ntpd on
t_ServiceControl ntpd start

NTPD_PID=$(pidof ntpd)

[ "$NTPD_PID" ] || { t_Log "FAIL: couldn't find 'ntpd' in the process list."; exit $FAIL; }
