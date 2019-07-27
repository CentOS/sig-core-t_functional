#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

# Install python
t_Log "Running $0 - installing python."

if [ "$centos_ver" -ge 8 ] ; then
t_InstallPackage python36
else
t_InstallPackage python
fi
