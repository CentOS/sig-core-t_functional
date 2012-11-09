#!/bin/bash
# Author: Ravi Kumar P <ravi.pasumarthy@gmail.com>, Anoop Hallur <anoophallur@gmail.com> 

# Check grep functionality with count of repititive words

t_Log "Running $0 - checking grep with count"

count=`echo -e "wow grep is working" | grep -c "wow"`
t_Log $count

t_Assert_Equals $count 1
