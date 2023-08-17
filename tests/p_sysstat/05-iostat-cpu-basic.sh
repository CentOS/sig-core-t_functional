#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# A simple iostat test to verify cpu loads are being recorded

t_Log "Running $0 - a basic iostat test to verify cpu measurement"

# Save our iostat output
output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

# Clear out the pagecache to get an accurate reading
echo 1 > /proc/sys/vm/drop_caches

# Capture a storage device name
drive=$(fdisk -l|grep -Po -m1 '^/dev/[\D]+')
 
# Run iostat on the cpu
/usr/bin/iostat -c 1 5 >${output_file} 2>&1 &

# Time for iostat booting
sleep 1

# Give the CPU something to chew on
/bin/dd if=$drive bs=4k count=25000 2>/dev/null|sha1sum -b - &>/dev/null

# Give iostat a chance to log our task
sleep 6

# Extract the CPU utilisation (user field, percentage)
cpu_user_percent=$(awk '$1 ~ /[0-9]/ {$1>a ? a=$1 : $1} END {print int(a)}' ${output_file})

# Confirm the CPU registered some level of user activity

if [ "$cpu_user_percent" -eq 0 ]; then
  t_Log "FAIL: ${0}: no cpu activity registered"
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_CheckExitStatus 0
