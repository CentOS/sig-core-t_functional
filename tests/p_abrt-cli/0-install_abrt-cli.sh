#!/bin/bash
# Author: Matej Habrnal <mhabrnal@redhat.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

if [[ $centos_ver == 7 ]]
then
    t_InstallPackage  abrt-cli expect curl python python-libs bc
else
    echo "Skipped on CentOS 5 and CentOS 6"
fi
