#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# A simple iostat test to verify transfers are being recorded

t_Log "Running $0 - a basic iostat test to verify disk measurement"

# Save our iostat output somewhere
TMP=/tmp/iostat.disk.scratch

# dd options
BS=4196
COUNT=10100
SUM=$(expr $BS \* $COUNT / 1024)

# Clean up after ourselves
trap "[ -e $TMP ] && { /bin/rm -f $TMP; }" EXIT

# Clear out the pagecache to get an accurate reading
echo 1 > /proc/sys/vm/drop_caches

# Capture a storage device name
DRIVE=$(fdisk -l|grep -Po -m1 '^/dev/[\D]+')

# Run iostat on the device
/usr/bin/iostat -dkx 1 5 $DRIVE >$TMP &

# Let the dust settle
sleep 1

# Generate some read traffic
/bin/dd if=$DRIVE of=/dev/null bs=$BS count=$COUNT &>/dev/null

# Give iostat a chance to log our traffic
sleep 3

# Confirm our read bytes are >0, excluding the first 
# line since that's the average since boot.
BYTES_READ=$(awk '$6 ~ /[0-9]/ {NR>1 && sum+=$6} END {print int(sum)}' $TMP)

# Check we read at least as much as requested
[ "$BYTES_READ" -ge "$SUM" ] || { t_Log "iostat didn't log as much traffic as we generated?!...that ain't good"; exit $FAIL; }

t_CheckExitStatus $?
