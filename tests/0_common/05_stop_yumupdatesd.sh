#!/bin/sh

t_Log "Running $0 - stopping yum-updatesd service"

/sbin/service yum-updatesd stop

sleep 2
