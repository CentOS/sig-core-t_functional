#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log 'Running $0 - autofs can mount nfs share test.'

t_Log 'Preparing autofs configuration'
cp -a /etc/auto.master /etc/auto.master_orig
echo '/autofs /etc/auto.autofs' >> /etc/auto.master
echo 'nfs -fstype=nfs 127.0.0.1:/var/lib' > /etc/auto.autofs

t_ServiceControl autofs start

t_Log 'Running test'

grep yum /autofs/nfs/
#t_CheckExitStatus $ret_val

# return everything to previous state
cp -a /etc/auto.master_orig /etc/auto.master
rm -rf /etc/auto.autofs
cat /dev/null > /etc/exports
