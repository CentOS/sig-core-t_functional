#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that sqlite can select from table."

sqlite3 /tmp/tf_test.db "select * from tf_table;" | grep -q 'tf_sample_text'

t_CheckExitStatus $?
