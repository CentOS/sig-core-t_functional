#!/bin/bash

# Start NTPd services and confirm it's running.

chkconfig ntpd on
service ntpd start

NTPD_PID=$(pidof ntpd)

[ -z "$NTPD_PID" ] && { t_Log "FAIL: couldn't find 'ntpd' in the process list."; exit $FAIL; }
