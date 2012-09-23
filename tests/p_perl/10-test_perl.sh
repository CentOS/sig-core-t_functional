#!/bin/bash
# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

# Check perl installation

t_Log "Running $0 - checking perl installation"

perl --version &>/dev/null
t_CheckExitStatus $?
