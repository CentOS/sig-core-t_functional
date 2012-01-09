#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that sqlite can dump database."

sqlite3 /tmp/tf_test.db ".dump" | grep -q 'tf_sample_text'

t_CheckExitStatus $?
