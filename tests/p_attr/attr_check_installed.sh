#!/bin/sh
# Author:  Dan Trainor <dan.trainor@gmail.com>
#          Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Checking to see if setfattr, getfattr work"


dd if=/dev/zero of=/tmp/attrtest.img bs=1024000 count=100 &>/dev/null
t_CheckExitStatus $?

echo -e 'y\n' | mkfs.ext3 /tmp/attrtest.img

mkdir /mnt/attr_test
mount -t ext3 -o loop,user_xattr /tmp/attrtest.img /mnt/attr_test
touch /mnt/attr_test/testfile
setfattr -n user.test /mnt/attr_test/testfile
getfattr /mnt/attr_test/testfile | grep -o "user.test"

t_CheckExitStatus $?

umount /mnt/attr_test
rm -f /tmp/attrtest.img
