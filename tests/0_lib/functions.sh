#!/bin/bash

# herein lies a set of common library functions
# any recurring code is welcome here

function t_Log
{
        printf "[+] `date` -> $*\n"
}

function t_CheckExitStatus
{
        [ $1 -eq 0 ] && { t_Log "PASS"; return $PASS; }

        t_Log "FAIL"
        exit $FAIL
}

function t_InstallPackage
{
        for P in $*; do

                t_Log "Attempting yum install of '$P'..."
                yum -y -d0 install $P
                t_CheckExitStatus $?
        done
}

function t_RemovePackage
{
        for P in $*; do

                t_Log "Attempting yum remove of '$P'..."
                yum -y -d0 remove $P
                t_CheckExitStatus $?
        done
}

function t_ProcessFolder
{
        while read f
        do
                # skip files named 'readme' or 'package_deps'
                [[ "${f}" =~ (readme|package_deps) ]] && continue;

                # all test scripts have to be executable
                # this allows us to enable/disable individual
                # tests by adding/removing the executable flag
                # the alternative is to have '/bin/bash $f' here
                # but I think the executable flag approach gives
                # us more flexibility...
                [ -x $f ] && $f

        done < $@
}

export -f t_Log
export -f t_CheckExitStatus
export -f t_InstallPackage
export -f t_RemovePackage
export -f t_ProcessFolder
