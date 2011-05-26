#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - installation and startup of dovecot IMAP/POP3."

t_InstallPackage dovecot
chkconfig dovecot on
t_ServiceControl dovecot start
