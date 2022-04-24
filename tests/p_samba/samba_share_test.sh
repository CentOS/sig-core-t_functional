#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - Samba share test."

cp /etc/samba/smb.conf /etc/samba/smb.conf.orig
cat > /etc/samba/smb.conf <<EOF
[global] 
workgroup = wrkgrp 
netbios name = smbsrv 
security = user
map to guest = Bad User

[testshare]
comment = Test share
path = /srv/smb
read only = yes
guest only = yes
EOF

# Reload the config
service smb restart
sleep 2

mkdir -p /srv/smb
echo "SMB test file" > /srv/smb/test.txt
mkdir /mnt/smb

# Fix SELinux context
chcon -R -t samba_share_t /srv/smb

# Mount the share
mount -t cifs -o guest,ro //127.0.0.1/testshare /mnt/smb
sleep 1

# Test 
cat /mnt/smb/test.txt | grep 'SMB test file' > /dev/null 2>&1

ret_val=$?
 
# Clean up
umount /mnt/smb
/bin/rm -fr /mnt/smb
 
t_CheckExitStatus $ret_val  

