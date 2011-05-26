#!/bin/sh

t_Log "Running $0 - stopping yum-updatesd service"
t_ServiceControl yum-updatesd stop
