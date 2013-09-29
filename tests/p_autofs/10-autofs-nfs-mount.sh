#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - autofs can mount nfs share test."

t_Log 'Preparing autofs configuration'
cp -a /etc/auto.master /etc/auto.master_orig
echo '/autofs /etc/auto.autofs' >> /etc/auto.master
echo 'nfs -fstype=nfs 127.0.0.1:/var/lib' > /etc/auto.autofs

t_ServiceControl autofs restart

t_Log 'Running test - accessing /var/lib via autofs'

ls -al /autofs/nfs | grep -q yum
t_CheckExitStatus $?

# return everything to previous state
cp -a /etc/auto.master_orig /etc/auto.master
rm -rf /etc/auto.autofs
cat /dev/null > /etc/exports
t_ServiceControl autofs stop
t_ServiceControl nfs stop
t_ServiceControl rpcbind stop
