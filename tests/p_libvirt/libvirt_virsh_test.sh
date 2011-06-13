#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Virsh test."

virsh -c test:///default list  > /dev/null

t_CheckExitStatus $?
