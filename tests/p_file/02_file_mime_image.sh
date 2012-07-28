#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking if file can recognize image mime file type "

file  /usr/lib/anaconda-runtime/boot/syslinux-splash.png -i | grep -q 'image/png'

t_CheckExitStatus $?

