#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - bind: local resolver can qualify 127.0.0.1"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

dig +timeout=1 +short @127.0.0.1 localhost | grep -q '127.0.0.1'

t_CheckExitStatus $?
