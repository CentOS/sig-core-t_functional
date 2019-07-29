#!/bin/bash
# Author Dries Verachtert <dries.verachtert@dries.eu>

# Install libxml2-python
t_Log "Running $0 - installing libxml2-python."

if [ "$centos_ver" -ge 8 ] ; then
t_InstallPackage python36 python3-libxml2
else
t_InstallPackage libxml2-python
fi
