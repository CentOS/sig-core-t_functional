#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>
#   Rene Diepstraten <rene@renediepstraten.nl>

t_Log "Running $0 - checking if file can recognize image mime file type "

pngfile="$(find /usr/share/ -name '*.png' -print -quit)"

file $pngfile -i | grep -q 'image/png'

t_CheckExitStatus $?
