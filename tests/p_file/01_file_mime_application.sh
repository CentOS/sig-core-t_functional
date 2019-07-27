#!/bin/bash
# Author:	???
#		Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking if file can recognize mime executable type "

if [ "$centos_ver" -eq "8" ] ;then
  string="application/x-sharedlib"
else
  string="application/x-executable"
fi

file /bin/bash -i | grep -q "${string}"

t_CheckExitStatus $?
