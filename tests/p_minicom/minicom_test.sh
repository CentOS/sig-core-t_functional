#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - very basic minicom test."

minicom -h | grep -q "terminal program"

t_CheckExitStatus $?
