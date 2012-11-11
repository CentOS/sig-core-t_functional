#!/bin/bash
# Author: Vivek Dubey <dvivek@thoughtworks.com>
# Akshay Karle <akshayka@thoughtworks.com> 
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - installing lzop"

if [ $centos_ver = 5 ]
  then
  t_Log "This is a C5 system. Skipping."
else
  t_InstallPackage lzop
fi
