#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - switching to mysql55 on C5."

if [ $centos_ver = 5 ]
then
  t_ServiceControl mysqld stop
  t_ServiceControl mysql55-mysqld start >/dev/null 2>&1
else
  t_Log "This is not a C5 system - skipping"
fi
