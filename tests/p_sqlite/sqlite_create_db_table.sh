#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that sqlite can database and tables."

sqlite3 /tmp/tf_test.db 'create table tf_table(text, id INTEGER);'

t_CheckExitStatus $?
