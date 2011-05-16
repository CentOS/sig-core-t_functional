#!/bin/sh

t_Log "Running $0 - test that all 32-bit rpms can be removed"

# only run this test on x86_64 machines!
is64=$(uname -m|grep x86_64)

# This is a non-fatal status, so return PASS.
[ $? -ne 0 ] && { t_Log 'Host is not 64bit, skipping.'; exit $PASS; }

t_RemovePackage *.i?86 