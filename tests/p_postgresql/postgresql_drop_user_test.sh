#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - PostgreSQL drop user test"

su - postgres -c 'dropuser test_user' > /dev/null 2>&1

t_CheckExitStatus $?
