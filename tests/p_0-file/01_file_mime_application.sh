#!/bin/bash

t_Log "Running $0 - checking if file can recognixe mime executable type "

file /bin/bash --mime-type | grep "application/x-executable"

t_CheckExitStatus $?
