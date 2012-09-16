#!/bin/bash
# Author: Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

# Check subversion installation

t_Log "Running $0 - checking subversion installation"

svn --version &>/dev/null
t_CheckExitStatus $?
