#!/bin/sh

t_Log "Running $0 - Yum configuration has the correct distroverpkg value test."

#add centos-userland-release for armhfp
uname_arch=$(uname -m)
if [ "$uname_arch" == "armv7l" ]; then
  rel_string="centos-userland-release"
else
  rel_string="centos-release"
fi

ProvierTag=$(grep distroverpkg /etc/yum.conf | cut -f2 -d'=')
rpm -q --whatprovides ${ProvierTag} | grep "$rel_string" > /dev/null
t_CheckExitStatus $?
