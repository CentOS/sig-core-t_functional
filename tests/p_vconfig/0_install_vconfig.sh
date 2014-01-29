#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

if [ $centos_ver -lt 7 ]
then
  # Install vconfig
  t_InstallPackage vconfig
else
  t_Log 'vconfig is only supported on C5 and C6, skipping'
fi
