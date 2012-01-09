#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that sqlite can insert into table."

sqlite3 /tmp/tf_test.db "insert into tf_table values ('tf_sample_text',1);"

t_CheckExitStatus $?
