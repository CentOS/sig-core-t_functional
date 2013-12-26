#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

if [ $centos_ver = 5 ] || [ $centos_ver = 6 ]
then
  # Install vconfig
  t_InstallPackage vconfig
else
  t_Log 'This is only supported on C5 and C6, skipping'
fi
