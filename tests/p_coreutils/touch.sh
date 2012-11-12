#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 testing touch and ls"

# Create two files
touch -t 198307081200 /var/tmp/touch-test-1
touch -t 198707071200 /var/tmp/touch-test-2

# ls -lt should show oldest file last
ls -lt /var/tmp/touch-test-? | tail -n 1 | grep -q "touch-test-1"

t_CheckExitStatus $?

# Cleanup
rm /var/tmp/touch-test-?
