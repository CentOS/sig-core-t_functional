#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - libvirt: Virsh can talk to local hypervisor."

virsh -c test:///default list  > /dev/null

t_CheckExitStatus $?
