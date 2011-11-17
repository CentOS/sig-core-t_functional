#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christph Galuschka <christoph.galuschka@tiwag.at>

t_Log "Running $0 - very basic minicom test."

# Only checking for correct output of '-v'

VERSION="2.3"

minicom -v | grep "${CHECK_FOR}"  >/dev/null 2>&1

t_CheckExitStatus $?
