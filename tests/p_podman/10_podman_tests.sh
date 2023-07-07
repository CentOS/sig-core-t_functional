#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - podman tests"

tests_in_order=(
    "podman version"
    "podman info"
    "podman run --rm quay.io/centos/centos:stream${centos_ver} bash -c 'echo HELLO' | grep -q -e 'HELLO'"
    "podman system service -t 1"
    "touch ${HOME}/test.txt && \
     podman run --rm --privileged -v ${HOME}/test.txt:/test.txt quay.io/centos/centos:stream${centos_ver} bash -c 'echo HELLO > /test.txt' && \
     grep -q -e 'HELLO' ${HOME}/test.txt && \
     rm -f ${HOME}/test.txt"
)

for cmd in "${tests_in_order[@]}"; do
  t_Log "Running $0: ${cmd}"
  if ! eval "${cmd}" > /dev/null 2>&1; then
    t_Log "FAIL: $0: ${cmd}"
    exit 1
  else
    t_Log "PASS: $0: ${cmd}"
  fi
done
