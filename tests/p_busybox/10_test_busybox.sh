#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - busybox test: busybox lists available functions."

busybox | grep -q 'Currently defined functions'
busy_ok=$?
if [ $busy_ok = 1 ]
  then
  t_Log 'busybox does not seem to list available functions'
fi
t_CheckExitStatus $busy_ok
