#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
# Description: this script sources our library functions and starts a test run.

echo -e "\n[+] `date` -> CentOS QA $0 starting."

LIB_FUNCTIONS='./tests/0_lib/functions.sh'

[ -f $LIB_FUNCTIONS ] && source $LIB_FUNCTIONS || { echo -e "\n[+] `date` -> Unable to source functions library. Cannot continue\n"; exit $FAIL; }

# case insensitive filename matching
shopt -s nocasematch

# exit as soon as any script returns a non-zero exit status
set -e

# exit on undefined variables
set -u

# process our test scripts
t_Process <(/usr/bin/find ./tests/0_*/ -type f|sort -t'/' )
t_Process <(/usr/bin/find ./tests/p_*/ -type f|sort -t'/' )
t_Process <(/usr/bin/find ./tests/r_*/ -type f|sort -t'/' )
t_Process <(/usr/bin/find ./tests/z_*/ -type f|sort -t'/' )

# and, we're done.
t_Log "QA t_functional tests finished."
exit 0
