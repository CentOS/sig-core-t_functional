#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

# A simple mpstat test to verify cpu load is being measured

t_Log "Running $0 - a simple mpstat test to verify cpu load is being measured"

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

n_cpu=$(nproc)
load=$((${n_cpu}/2))
if [ "${load}" -eq 0 ]; then
 load=1
fi

/usr/bin/mpstat 1 5 >${output_file} 2>&1 &

# Time for iostat booting
sleep 1

# Give the CPU something to chew on
for i in $(seq 1 ${load}); do 
  sha1sum /dev/zero &
done

# Give mpstat a chance to log our task
sleep 6

killall sha1sum

cpu_user_percent=$(awk '$4 ~ /[0-9]\./ {$4>a ? a=$4 : $4} END {print int(a)}' ${output_file})

if [ "$cpu_user_percent" -eq 0 ]; then
  t_Log "FAIL: ${0}: no cpu activity registered"
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_CheckExitStatus 0
