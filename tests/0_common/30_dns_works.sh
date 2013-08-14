#!/bin/bash

t_Log "Running $0 - testing to see if DNS works"
if [ $SKIP_QA_HARNESS -eq 1 ]; then 
  HOST=ci.dev.centos.org 
else
  HOST=repo.centos.qa
fi

# its important we dont hit a dns record with a wildcard like centos.org
/bin/ping -c 1 $HOST &>/dev/null

t_CheckExitStatus $?

# implied results:
# - network works
# - default route is really routeable
# - atleast one network link on the machine is working
# - kernel' ip stack is functional
