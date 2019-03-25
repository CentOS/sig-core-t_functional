#!/usr/bin/env bash

# Author: Alex Baranowski <aleksander dot baranowski at yahoo.pl>
# This test makes sosreport. Then check if the sosreport file is bigger than 1MiB.

t_Log "Running $0"
export MY_ID="${RANDOM}-$$"
export MINIMAL_SIZE=1048576 # 1MiB

cleanup(){
  t_Log "Removing the sosreport files"
  rm -f /tmp/sosreport*${MY_ID}*tar*  >/dev/null
  rm -f /var/tmp/sosreport*${MY_ID}*tar*  >/dev/null
}

t_Log "$0 tests sosreport generaton"

tests(){
  yes "$MY_ID" | sosreport 
  # shellcheck disable=SC2086
  SOS_SIZE=$(stat -c "%s" $1/sosreport*${MY_ID}*tar.xz)
  t_Log "Check for minimal size of generated sosreport"
  [ "$SOS_SIZE" -gt "$MINIMAL_SIZE" ]
  t_checkExitStatus $?
}

if [ "$centos_ver" -gt 6 ]; then 
  tests "/var/tmp"
else 
  tests "/tmp"
fi
cleanup
