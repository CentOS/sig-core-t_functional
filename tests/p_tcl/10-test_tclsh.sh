#!/bin/bash

# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

t_Log "Running $0 - Testing tclsh by running it with a basic file"

echo 'puts "helloworld tclpackage"' > testfile
tclsh testfile

t_CheckExitStatus $?
