#!/bin/bash

t_Log "Running $0 - checking if file can recognize image mime file type "

file  /usr/lib/anaconda-runtime/boot/syslinux-splash.png --mime-type | grep 'image/png'

t_CheckExitStatus $?

