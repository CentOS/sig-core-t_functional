#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - tmpwatch test."

# create a junk file
touch -t '200001010000' /tmp/tf_test

tmpwatch 24 /tmp

[ ! -f /tmp/tf_test ]

t_CheckExitStatus $?
