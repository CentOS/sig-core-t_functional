#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Rene Diepstraten <rene@renediepstraten.nl>

t_Log "Running $0 - check if chkconfig can list a service status"

# network is used as example because it's standard with minimal install

chkconfig --list network | grep -q '3:on'

t_CheckExitStatus $?

