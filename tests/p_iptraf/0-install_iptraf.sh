#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

t_Log "Running $0 - iptraf: install iptraf and which"

# IPTraf traffic monitoring package
t_InstallPackage iptraf

# Required by the test
t_InstallPackage which
