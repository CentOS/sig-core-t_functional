#!/bin/sh

t_Log "Running $0 - test that all updates can be applied to this machine cleanly"

yum -d0 -y upgrade
ret_val=$?

t_Log "Resourcing lib-functions - see CVE-2014-6271"
LIB_FUNCTIONS='./tests/0_lib/functions.sh'
source $LIB_FUNCTIONS

t_CheckExitStatus $ret_val
