#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking if file can recognize symlink mime file type "

if (t_GetPkgRel basesystem | grep -q el5)
  then
  file -i /etc/grub.conf | grep -q 'x-not-regular-file'
  ret_val=$?
else
  file -i /etc/grub.conf | grep -q 'application/x-symlink'
  ret_val=$?
fi

t_CheckExitStatus $ret_val
