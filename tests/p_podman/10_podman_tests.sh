#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - podman tests"

if [ "$centos_ver" -lt 8 ] ; then
  t_Log "SKIP $0: only run on centos stream 8 or greater"
  exit 0
fi

tests_in_order=(
    "podman version"
    "podman info"
    "podman run --rm quay.io/centos/centos:stream${centos_ver} bash -c 'echo HELLO' | grep -q -e 'HELLO'"
    "podman system service -t 1"
    "touch ${HOME}/test.txt && \
     podman run --rm --privileged -v ${HOME}/test.txt:/test.txt quay.io/centos/centos:stream${centos_ver} bash -c 'echo HELLO > /test.txt' && \
     grep -q -e 'HELLO' ${HOME}/test.txt && \
     rm -f ${HOME}/test.txt"
    "printf \"FROM quay.io/centos/centos:stream${centos_ver}\nCMD echo 'HELLO'\n\" > ${HOME}/Containerfile && \
     podman build -t test:latest -f ${HOME}/Containerfile && \
     podman image rm localhost/test:latest && \
     rm -rf ${HOME}/Containerfile"
)

output_file=$(mktemp)
trap "rm -f ${output_file}" EXIT

for cmd in "${tests_in_order[@]}"; do
  t_Log "Running $0: ${cmd}"
  if ! eval "${cmd}" > ${output_file} 2>&1; then
    t_Log "FAIL: $0: ${cmd}"
    cat ${output_file}
    exit 1
  else
    t_Log "PASS: $0: ${cmd}"
  fi
done

