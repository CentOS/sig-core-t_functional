#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>
#   Rene Diepstraten <rene@renediepstraten.nl>

t_Log "Running $0 - checking if file can recognize image mime file type "

case $centos_ver in
  5|6)
    pngfile=/usr/lib/anaconda-runtime/boot/syslinux-splash.png
    ;;
  *)
    pngfile=/usr/share/anaconda/boot/syslinux-splash.png
    ;;
esac

file $pngfile -i | grep -q 'image/png'

t_CheckExitStatus $?