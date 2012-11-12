#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 - Test yes command"

# Create test files
touch /var/tmp/test-yes-123
touch /var/tmp/test-yes-456

# -i makes rm ask for confirmation with 'y' so pipe yes to it
yes | rm -i /var/tmp/test-yes-* || exit 1

#Set deleted to 1, until we've succesfully tested that the files have gone
deleted=1
#Test that the files don't exist then set deleted=0
test -f /var/tmp/test-yes-123 || test -f /var/tmp/test-yes-456 || deleted=0
t_CheckExitStatus $deleted
