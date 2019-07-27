#!/bin/bash
# Author : Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

if  [ $# -eq 0 ]
then
  bridge=testbridge1
else
  bridge=$1
fi

. "$(dirname "$0")"/p_bridge-utils-functions

t_Log "Running $0 - Adding a dummy Bridge: $bridge"
ret_val=$(bru_add_bridge $bridge)

t_CheckExitStatus $ret_val
bru_del_bridge $bridge >/dev/null
exit $ret_val
