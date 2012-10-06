#!/bin/bash

# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

t_Log "Running $0 - Testing perl by running it against a basic file"

echo 'print "helloworld perlpackage"' > testfile
perl testfile | grep -q helloworld

t_CheckExitStatus $?
