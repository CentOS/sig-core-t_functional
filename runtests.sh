#!/bin/bash

export readonly PASS=0
export readonly FAIL=1

echo -e "\n[+] `date` -> CentOS QA $0 starting."

LIB_FUNCTIONS='./tests/0_lib/functions.sh'

[ -f $LIB_FUNCTIONS ] && source $LIB_FUNCTIONS || { echo -e "\n[+] `date` -> Unable to source functions library. Cannot continue\n"; exit $FAIL; }

# case insensitive filename matching
shopt -s nocasematch

# exit as soon as any script returns a non-zero exit status
set -e

t_ProcessFolder <(/usr/bin/find ./tests/0_common/ -type f|sort) 
t_ProcessFolder <(/usr/bin/find ./tests/p_* -type f|sort)
t_ProcessFolder <(/usr/bin/find ./tests/r_* -type f|sort)

t_Log "Finished."
