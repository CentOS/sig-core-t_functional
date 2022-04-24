#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - NFS writable share test."

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

cp /etc/exports /etc/exports.orig
echo '/srv/nfs *(rw,sync,no_root_squash)' >/etc/exports
mkdir -p /srv/nfs
exportfs -ar

# Fix SELinux boolean
setsebool allow_nfsd_anon_write 1

# Mount the share
mkdir /mnt/nfs
mount -t nfs 127.0.0.1:/srv/nfs /mnt/nfs || exit 1
echo 'NFS test file' > /mnt/nfs/test.txt

# Test twice
(cat /mnt/nfs/test.txt | grep 'NFS test file' > /dev/null 2>&1) && \
(cat /srv/nfs/test.txt | grep 'NFS test file' > /dev/null 2>&1)
ret_val=$?

# Clean up
umount /mnt/nfs
/bin/rm -fr /mnt/nfs
mv /etc/exports.orig /etc/exports

t_CheckExitStatus $ret_val
