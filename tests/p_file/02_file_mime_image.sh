#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>
#   Rene Diepstraten <rene@renediepstraten.nl>

t_Log "Running $0 - checking if file can recognize image mime file type "

pngfile="$(find /usr/share/ -type f -name '*.png' -print -quit)"

if [ -z "$pngfile" ];then
    t_Log "No png file found => SKIP"
    exit 0
fi

file $pngfile -i | grep -q 'image/png'

t_CheckExitStatus $?
