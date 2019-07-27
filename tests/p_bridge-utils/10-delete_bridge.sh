#!/bin/bash
# Author : Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

. "$(dirname "$0")"/p_bridge-utils-functions
#add bridge
bridge=testbridge2
bru_add_bridge $bridge >/dev/null

t_Log "Running $0 - Deleting the dummy bridge: $bridge"

t_Log "Deleting bridge $bridge"
ret_val=$(bru_del_bridge $bridge)

t_CheckExitStatus $ret_val
