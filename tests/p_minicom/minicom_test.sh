#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christph Galuschka <christoph.galuschka@tiwag.at>

t_Log "Running $0 - very basic minicom test."

minicom -h | grep -q "terminal program"

t_CheckExitStatus $?
