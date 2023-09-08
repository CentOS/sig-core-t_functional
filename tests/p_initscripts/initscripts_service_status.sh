#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - check if service cmd can get service status"

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

# auditd is used as example because it's standard with minimal install
if ! service auditd status > ${output_file} 2>&1; then
  cat ${output_file}
  t_CheckExitStatus 1
fi

t_CheckExitStatus 0
