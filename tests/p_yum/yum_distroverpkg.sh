#!/bin/sh

t_Log "Running $0 - Yum configuration has the correct distroverpkg value test."

ProvierTag=$(grep distroverpkg /etc/yum.conf | cut -f2 -d'=')
rpm -q --whatprovides ${ProvierTag} | grep centos-release > /dev/null
t_CheckExitStatus $?