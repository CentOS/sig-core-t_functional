#!/bin/sh

t_Log "Running $0 - Showing the repos we have configured"

yum -d0 repollist -v

t_CheckExitStatus $?
