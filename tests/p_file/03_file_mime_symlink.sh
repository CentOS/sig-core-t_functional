#!/bin/bash

t_Log "Running $0 - checking if file can recognize symlink mime file type "

file  /etc/favicon.png --mime-type | grep 'application/x-symlink'

t_CheckExitStatus $?
