#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>


t_Log "Running $0"

output_file=$(mktemp)
trap "rm -f ${output_file}; rm -f perf.data" EXIT

t_Log "Running $0: perf record"
if ! perf record -F 49 -a -g -- sleep 1 > ${output_file} 2>&1; then
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_Log "Running $0: perf report"
if ! perf report --stats > ${output_file} 2>&1; then
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_CheckExitStatus 0
