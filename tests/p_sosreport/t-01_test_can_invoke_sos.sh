#!/usr/bin/env bash
# Author: Alex Baranowski <aleksander dot baranowski at yahoo.pl>

# This is the most basic test that checks if the sosreport can load.
# When sosreport list its plugin it has to load the policy (CentOS patch that).
# If the patch breaks policy, it's likely that it won't produce any meaningful output.

t_Log "$0 tests for policy loading"
sosreport -l  > /dev/null 2>&1
t_CheckExitStatus $?
