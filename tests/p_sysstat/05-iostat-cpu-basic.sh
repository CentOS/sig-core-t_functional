#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# A simple iostat test to verify cpu loads are being recorded

t_Log "Running $0 - a basic iostat test to verify cpu measurement"

# Save our iostat output somewhere
TMP=/tmp/iostat.cpu.scratch

# Clear out the pagecache to get an accurate reading
echo 1 > /proc/sys/vm/drop_caches

# Clean up after ourselves
trap "[ -e $TMP ] && { /bin/rm -f $TMP; }" EXIT

# Capture a storage device name
DRIVE=$(fdisk -l|grep -Po -m1 '^/dev/[\D]+')
 
# Run iostat on the cpu
/usr/bin/iostat -c 1 5 >$TMP &

# Let the dust settle
sleep 4

# Give the CPU something to chew on
/bin/dd if=$DRIVE bs=4k count=25000 2>/dev/null|sha1sum -b - &>/dev/null

# Give iostat a chance to log our task
sleep 6

# Extract the CPU utilisation (user field, percentage)
CPU_USER_PCENT=$(awk '$1 ~ /[0-9]/ {$1>a ? a=$1 : $1} END {print int(a)}' $TMP)

# Confirm the CPU registered some level of user activity
[ "$CPU_USER_PCENT" -gt 3 ] || { t_Log "iostat didn't log any CPU activity?!...that ain't good"; }

t_CheckExitStatus $?
