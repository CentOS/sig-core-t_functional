#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - installation and startup of dovecot IMAP/POP3."

# Install some pkgs needed by the tests
t_InstallPackage nc grep dovecot

t_ServiceControl dovecot start
