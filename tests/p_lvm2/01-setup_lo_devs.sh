#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - setting up loopback devices for LVM tests."

# We need a fixed path for the other tests to avoid exporting variables

#img_temp_dir=`mktemp -d /tmp/img_temp_dir.XXXXXXXXXX`
img_temp_dir="/tmp/t_lvm_temp_dir"

# Create few disk images and loopback devices
mkdir -p $img_temp_dir
for i in `seq 0 4` ; do
    dd if=/dev/zero of=$img_temp_dir/disk${i}.img bs=64K count=8192
    losetup -f $img_temp_dir/disk${i}.img
done

t_CheckExitStatus $?
