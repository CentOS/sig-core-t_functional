#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - shells file sanity check."

grep -q 'bash' /etc/shells 


t_CheckExitStatus $?
