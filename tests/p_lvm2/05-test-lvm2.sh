#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - Basic LVM tests."

pvs &&\
vgs &&\
lvs

t_CheckExitStatus $?
