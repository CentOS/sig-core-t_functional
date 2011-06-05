#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# A simple mpstat test to verify cpu load is being measured

t_Log "Running $0 - a simple mpstat test to verify cpu load is being measured"

# Save our iostat output somewhere
TMP=/tmp/mpstat.scratch

# Clean up after ourselves
trap "[ -e $TMP ] && { /bin/rm -f $TMP; }" EXIT

# Run iostat on the first CPU
/usr/bin/mpstat -P 0 1 5 >$TMP &

# Let the dust settle
sleep 1

# Give the CPU something to chew on
/bin/dd if=/dev/urandom bs=1k count=10000 2>/dev/null|sha1sum -b - &>/dev/null

# Give mpstat a chance to log our task
sleep 3

# Confirm our read bytes are >0, excluding the first 
# line since that's the average since boot.
CPU_SYS_PCENT=$(awk '$6 ~ /[0-9]\./ {$6>a ? a=$6 : $6} END {print int(a)}' $TMP)

# Check mpstat registered some level of cpu activity
[ "$CPU_SYS_PCENT" -gt 5 ] || { t_Log "mpstat didn't log any CPU activity?!...that ain't good"; exit $FAIL; }

t_CheckExitStatus $?
