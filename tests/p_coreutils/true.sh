#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test true command"
true
t_CheckExitStatus $?
