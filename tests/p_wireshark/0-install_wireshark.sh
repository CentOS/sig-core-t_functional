#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el6)
then
    # Install wireshark
    t_InstallPackage wireshark
else 
    echo "Skipped on CentOS 5"
fi
