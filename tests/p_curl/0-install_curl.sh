#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "$0 - installing curl"
if [ "$centos_ver" -ge "9" ]; then
  binary=$(which curl)
  if [ -z $binary ]; then
    t_InstallPackage curl-minimal
  fi
else
  t_InstallPackage curl
fi

