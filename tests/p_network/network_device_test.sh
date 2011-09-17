#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Check if a least one network device is available."

ifconfig | grep -q eth0

t_CheckExitStatus $?
