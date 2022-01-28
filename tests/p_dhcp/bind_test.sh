#!/bin/sh
# Author: Petr Menšík <pemensik@redhat.com>

t_Log "Running $0 - dhcp-client: can upgrade client"

dnf upgrade --assumeno 'bind*' 'dhcp*'

t_CheckExitStatus $?
