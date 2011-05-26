#!/bin/bash

# Start NTPd services and confirm it's running.
chkconfig ntpd on
t_ServiceControl ntpd start

NTPD_PID=$(pidof ntpd)

[ -z "$NTPD_PID" ] && { t_Log "FAIL: couldn't find 'ntpd' in the process list."; exit $FAIL; }

# this is here because otherwise the [ operator exit 
# status would become the return value from the function
exit 0
