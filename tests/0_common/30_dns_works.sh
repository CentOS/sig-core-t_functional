#!/bin/bash

t_Log "Running $0 - testing to see if DNS works"

# its important we dont hit a dns record with a wildcard like centos.org
/bin/ping -c 1 repo.centos.qa &>/dev/null

t_CheckExitStatus $?

# implied results:
# - network works
# - default route is really routeable
# - atleast one network link on the machine is working
# - kernel' ip stack is functional
