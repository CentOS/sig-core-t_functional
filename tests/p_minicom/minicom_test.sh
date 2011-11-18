#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - minicom binary load test."

# FIXME: this test is very basic
minicom -h | grep -q "terminal program"

t_CheckExitStatus $?
