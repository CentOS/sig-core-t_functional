#!/bin/bash
# Author : Varadharajan M <srinathsmn@gmail.com>
#          Manoj Mahalingam <manojlds@gmail.com>

t_Log "Running $0 - Testing basic bc functionalities"
test `echo "5 + 6 * 5 / 10 - 1" | bc` -eq "7"
t_CheckExitStatus $?
