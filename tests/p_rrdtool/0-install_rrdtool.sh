#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>
#         Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel basesystem | grep -q el6)
then
    # Install rrdtool
    t_InstallPackage rrdtool
else 
    echo "Skipped on CentOS 5"
fi

