#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
# Description: this script sources our library functions and starts a test run.

echo -e "\n[+] `date` -> CentOS QA $0 starting."

yum -d0 -y install bind-utils 

host repo.centos.qa > /dev/null
export SKIP_QA_HARNESS=$?

LIB_FUNCTIONS='./tests/0_lib/functions.sh'

# Just in case $LIB_FUNCTIONS doesn't exist
export FAIL=1

[ -f $LIB_FUNCTIONS ] && source $LIB_FUNCTIONS || { echo -e "\n[+] `date` -> Unable to source functions library. Cannot continue\n"; exit $FAIL; }

# case insensitive filename matching
shopt -s nocasematch

# exit as soon as any script returns a non-zero exit status
set -e

# exit on undefined variables
set -u

# process our test scripts
if [ $# -gt 0 ]; then
  t_Process <(/usr/bin/find ./tests/0_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/$1/ -type f|sort -t'/' )
else
  t_Process <(/usr/bin/find ./tests/0_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/p_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/r_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/z_*/ -type f|sort -t'/' )
fi

# and, we're done.
t_Log "QA t_functional tests finished."
exit 0
