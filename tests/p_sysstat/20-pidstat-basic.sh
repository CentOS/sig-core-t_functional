#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - pidstat test"

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

if ! pidstat 1 1 > ${output_file} 2>&1; then
  cat ${output_file}
  exit 1
fi
