#!/bin/bash
# Author: Matej Habrnal <mhabrnal@redhat.com>

if [[ $centos_ver == 7 ]]
then
    t_InstallPackage  abrt-cli
    t_InstallPackage  expect
    t_InstallPackage  curl
    t_InstallPackage  python
    t_InstallPackage  python-libs
else
    echo "Skipped on CentOS 5 and CentOS 6"
fi
