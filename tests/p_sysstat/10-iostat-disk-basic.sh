#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# A simple iostat test to verify transfers are being recorded

t_Log "Running $0 - a basic iostat test to verify disk measurement"

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

# dd options
bs=4196
count=10100
sum=$(expr $bs \* $count / 1024)


# Clear out the pagecache to get an accurate reading
echo 1 > /proc/sys/vm/drop_caches

# Capture a storage device name
drive=$(fdisk -l|grep -Po -m1 '^/dev/[\D]+')

# Run iostat on the device
/usr/bin/iostat -d 1 5 $drive >${output_file} 2>&1 &

# Time for iostat booting
sleep 1

# Generate some read traffic
/bin/dd if=$drive of=/dev/null bs=$bs count=$count &>/dev/null

# Give iostat a chance to log our traffic
sleep 6

# Confirm our read bytes are >0, excluding the first 
# line since that's the average since boot.
kbytes_read=$(awk '$6 ~ /[0-9]/ {NR>1 && sum+=$6} END {print int(sum)}' ${output_file})

if [ "$kbytes_read" -eq 0 ]; then
  t_Log "FAIL: ${0}: no io activity registered"
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_CheckExitStatus 0
