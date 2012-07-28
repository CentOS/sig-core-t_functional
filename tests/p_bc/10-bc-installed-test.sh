#!/bin/bash
# Author : Varadharajan M <srinathsmn@gmail.com>
#          Manoj Mahalingam <manojlds@gmail.com>

t_Log "Running $0 - Test bc is installed"
bc --version
t_CheckExitStatus $?
