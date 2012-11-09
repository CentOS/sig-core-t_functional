#!/bin/bash
# Author: Ravi Kumar P <ravi.pasumarthy@gmail.com>, Anoop Hallur <anoophallur@gmail.com>

# Check grep functionality 

t_Log "Running $0 - checking grep functionality"

echo "wow grep is working" | grep "wow"
t_CheckExitStatus $?
