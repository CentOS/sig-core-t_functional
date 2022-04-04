#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - iptraf: install iptraf and which"

# IPTraf traffic monitoring package
t_InstallPackage iptraf

# Required by the test
t_InstallPackage which
