#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - perf tests"

tests_in_order=(
    "perf version"
    "perf record -F 49 -a -g -- sleep 1"
    "perf report --stdio > /dev/null 2>&1"
)

for cmd in "${tests_in_order[@]}"; do
  t_Log "Running $0 - perf test: ${cmd}"
  if ! eval "${cmd}" > /dev/null 2>&1; then
    t_Log "FAIL: $0: perf test: ${cmd}"
    exit 1
  else
    t_Log "PASS: $0: perf test: ${cmd}"
  fi
done

t_Log "Cleaning up $0 - perf tests data"
rm -f perf.data
