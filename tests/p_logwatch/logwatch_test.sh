#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - logwatch test."

logwatch --print | grep -q 'Logwatch End'

t_CheckExitStatus $?
