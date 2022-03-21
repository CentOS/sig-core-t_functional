#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - rsyncd can rsync from/to local machine."

# create settings to run test

PATH2FILE='/var/tmp/rsync'
mkdir -p $PATH2FILE
FILE='rsync-test'
cat > $PATH2FILE/$FILE <<EOF
Testing rsync
EOF

# Creating rsyncd config file
cat > /etc/rsyncd.conf <<EOF
gid = root
uid = root
read only = true
use chroot = true
log file = /var/log/rsyncd.log
pid file = /var/run/rsyncd.pid
hosts allow = 127.0.0.1
[centos-test]
 path = $PATH2FILE
 list = yes
 exclude = *
 include = $FILE
EOF

if [ "$centos_ver" -ge 7 ]; then
 systemctl start rsyncd.service
else
 t_ServiceControl xinetd restart
fi

# Fix SELinux
chcon -R -t public_content_t $PATH2FILE

# Trying to rsync
rsync --recursive --verbose --include=$FILE --exclude=* rsync://127.0.0.1/centos-test /var/log/

t_CheckExitStatus $?

#reverting changes
/bin/rm $PATH2FILE/$FILE
/bin/rm /var/log/$FILE

if [ "$centos_ver" -ge 7 ]; then
 systemctl start rsyncd.service
else
 /bin/rm /etc/rsyncd.conf
 t_ServiceControl xinetd restart
fi
