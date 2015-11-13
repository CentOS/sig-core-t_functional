#!/bin/bash
# Author:	???
#		Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking if file can recognize mime executable type "

file /bin/bash -i | grep -q "application/x-executable"

t_CheckExitStatus $?
