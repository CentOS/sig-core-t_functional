#!/bin/bash

t_Log "Running $0 - checking if file package is installed"

rpm -q file > /dev/null 2>&1

t_CheckExitStatus $?
