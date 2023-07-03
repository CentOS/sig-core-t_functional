#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - sa tests"

tests_in_order=(
    "/usr/lib64/sa/sa1 --boot"
    "sar -u | grep -q -e 'LINUX RESTART'"
    "/usr/lib64/sa/sa1 1 1"
    "sleep 3 && /usr/lib64/sa/sa1 1 1 && sar -u | grep -q -e 'Average'"
    "/usr/lib64/sa/sa2 -A"
)

for cmd in "${tests_in_order[@]}"; do
  t_Log "Running $0 - sa test: ${cmd}"
  if ! eval "${cmd}" > /dev/null 2>&1; then
    t_Log "FAIL: $0: sa test: ${cmd}"
    exit 1
  else
    t_Log "PASS: $0: sa test: ${cmd}"
  fi
done
