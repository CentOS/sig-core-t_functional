#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - NFS writable share test."

cp /etc/exports /etc/exports.orig
echo '/srv/nfs *(rw,sync,no_root_squash)' >/etc/exports
mkdir -p /srv/nfs
exportfs -ar

# Mount the share
mkdir /mnt/nfs
mount -t nfs 127.0.0.1:/srv/nfs /mnt/nfs
echo 'NFS test file' > /mnt/nfs/test.txt

# Test twice
(cat /mnt/nfs/test.txt | grep 'NFS test file' > /dev/null 2>&1) && \
(cat /srv/nfs/test.txt | grep 'NFS test file' > /dev/null 2>&1)

t_CheckExitStatus $?
