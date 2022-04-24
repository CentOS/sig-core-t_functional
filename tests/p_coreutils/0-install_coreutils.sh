#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 - installing coreutils"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_InstallPackage coreutils-single
else
    t_InstallPackage coreutils
fi