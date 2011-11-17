#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>

t_Log "Running $0 - basic firefox test."

# Only checking for correct output of '-v'
# both C5/C6 use V3.6

VERSION="3.6"

firefox -v | grep "${VERSION}" >/dev/null 2>&1

t_CheckExitStatus $?
