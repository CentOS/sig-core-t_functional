#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - cracklib can check some passwords."
ret_val=0

t_Log "checking very simple password"
echo -e "test" | cracklib-check | grep -q 'too short'
t_CheckExitStatus $?

t_Log "checking simple password"
echo -e "testing" | cracklib-check | grep -q 'dictionary'
t_CheckExitStatus $?

t_Log "checking simplistic password"
echo -e "1234_Hgi" | cracklib-check | grep -q 'simplistic'
t_CheckExitStatus $?

t_Log "checking complicated password"
echo -e "1536_Hargi" | cracklib-check | grep -q 'OK'
t_CheckExitStatus $?
