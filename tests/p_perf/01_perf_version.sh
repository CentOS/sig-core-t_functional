#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>


t_Log "Running $0"

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

if ! perf version > ${output_file} 2>&1; then
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_CheckExitStatus 0
