#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
# Description: this script sources our library functions and starts a test run.

echo -e "\n[+] `date` -> CentOS QA $0 starting."

yum -d0 -y install bind-utils 

if [ "$?" -ne "0" ] ;then
  echo "[+] ERROR : not even able to install bind-utils pkg so all t_functional tests will fail"
  echo "[+] Do we have enabled repositories with correct GPG settings and signed pkgs ?"
  exit 1
fi

host repo.centos.qa > /dev/null
export SKIP_QA_HARNESS=$?

LIB_FUNCTIONS='./tests/0_lib/functions.sh'

# Human friendly symbols
export readonly PASS=0
export readonly FAIL=1
# set debug level of yum install in t_InstallPackage
export YUMDEBUG=0

[ -f $LIB_FUNCTIONS ] && source $LIB_FUNCTIONS || { echo -e "\n[+] `date` -> Unable to source functions library. Cannot continue\n"; exit $FAIL; }

# case insensitive filename matching
shopt -s nocasematch

# exit as soon as any script returns a non-zero exit status
set -e

# exit on undefined variables
set -u

# Searching for tests to disable
if [ -e skipped-tests.list ] ;then
  t_Log "QA Harness : searching for tests to disable with valid reason"
  egrep ^${centos_ver} skipped-tests.list | while read line; 
    do test=$(echo $line|cut -f 2 -d '|')
    t_Log "Disabling QA harness test ${test}"
    chmod -x ${test}
  done
fi

# process our test scripts

t_Process <(/usr/bin/find ./tests/0_*/ -type f|sort -t'/' )
if [ $# -gt 0 ]; then
  t_Process <(/usr/bin/find ./tests/$1/ -type f|sort -t'/' )
else
  t_Process <(/usr/bin/find ./tests/p_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/r_*/ -type f|sort -t'/' )
  # For now we skipping these tests on AlmaLinux
  if [[ $is_almalinux == "no" ]]; then
    t_Process <(/usr/bin/find ./tests/z_*/ -type f|sort -t'/' )
  fi
fi

# and, we're done.
if [ -e skipped-tests.list ] ;then
  t_Log "QA Harness : Searching for disabled tests (skipped-tests.list)"
  egrep ^${centos_ver} skipped-tests.list | while read line; 
    do test=$(echo $line|cut -f 2 -d '|')
    reason=$(echo $line|cut -f 3 -d '|')
    t_Log " =WARNING= : Disabled test : ${test} (${reason})" 
  done
fi

t_Log "QA t_functional tests finished."
exit 0
