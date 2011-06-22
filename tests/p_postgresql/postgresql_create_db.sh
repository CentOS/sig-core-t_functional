#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - PostgreSQL create database test"
su - postgres -c 'createdb pg_testdb' > /dev/null 2>&1
t_CheckExitStatus $?
