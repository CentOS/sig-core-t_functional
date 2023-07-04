#!/bin/bash
# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - pidstat test"

pidstat 1 1 > /dev/null 2>&1
t_CheckExitStatus $?
