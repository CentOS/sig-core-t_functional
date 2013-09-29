#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - autofs can mount nfs share test."

t_Log 'Preparing autofs configuration'
cp -a /etc/auto.master /etc/auto.master_orig
cat '/autofs /etc/auto.autofs' >> /etc/auto.master
cat 'nfs -fstype=nfs 127.0.0.1:/var/lib' > /etc/auto.autofs

t_ServiceControl autofs start

t_Log 'Running test'

grep yum /autofs/nfs/
#t_CheckExitStatus $ret_val
