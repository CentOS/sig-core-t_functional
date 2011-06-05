#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

t_Log "Running $0 - checking iptraf runs and returns non-zero exit status."

TMP=/tmp/iptraf.log

# clean up after ourselves
trap "[ -e ${TMP} ] && { /bin/rm ${TMP}; }" EXIT

# iptraf only be run by root
[ ${EUID} -eq 0 ] || { t_Log "Not running as root, skipping this test. Non-fatal."; exit $PASS; }

IPTRAF=`which iptraf`
PING=`which ping`
STAT=`which stat`
KILL=`which kill`

[ "$IPTRAF" ] || { t_log "Failed to find iptraf binary. That ain't good..."; exit $FAIL; }
[ "$PING" ] || { t_Log "Failed to find the ping binary. That ain't good..."; exit $FAIL; }
[ "$STAT" ] || { t_Log "Failed to find the stat binary. That ain't good..."; exit $FAIL; }
[ "$KILL" ] || { t_Log "Failed to find the kill binary. That ain't good..."; exit $FAIL; }

# start iptraf running in the background on all interfaces, logging to a file.
${IPTRAF} -i all -t 1 -B -L ${TMP} &>/dev/null

# give iptraf something to chew on
${PING} -c 5 127.0.0.1 &>/dev/null

# check the our log file actually has some data in it, which it should, given that we just pinged ourselves...
LOGSIZE=`stat -c '%s' ${TMP}`

# kill iptraf
${KILL} -USR2 `pidof iptraf`

# confirm our iptraf log file has something in it
[ ${LOGSIZE} -gt 0 ] || { t_Log "iptraf failed to log any traffic?!. That ain't good..."; exit $FAIL; }

