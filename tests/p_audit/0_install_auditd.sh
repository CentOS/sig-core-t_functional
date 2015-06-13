#!/bin/bash

# Install tests deps
t_Log "Running $0 - auditd"


t_InstallPackage auditd
t_ServiceControl auditd restart

