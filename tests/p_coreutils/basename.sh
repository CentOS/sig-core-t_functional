#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 testing basename"

basename $0 | grep -q basename.sh || exit 1
basename /etc/hosts | grep -q hosts
t_CheckExitStatus $?

