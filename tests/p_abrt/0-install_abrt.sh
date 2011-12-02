#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>


if (t_GetPkgRel basesystem | grep -q el6)
then
    t_InstallPackage  abrt
else 
    echo "Skipped on CentOS 5"
fi
