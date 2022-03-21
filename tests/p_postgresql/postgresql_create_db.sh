#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - PostgreSQL create database test"
if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Postgres needs to be initialized."
  /usr/bin/postgresql-setup --initdb
fi

su - postgres -c 'createdb pg_testdb'
t_CheckExitStatus $?
