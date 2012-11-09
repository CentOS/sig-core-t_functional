#!/bin/bash
# Author: Ravi Kumar P <ravi.pasumarthy@gmail.com>, Anoop Hallur <anoophallur@gmail.com> 

# Check grep installation

t_Log "Running $0 - checking grep installation"

grep --version &>/dev/null
t_CheckExitStatus $?
