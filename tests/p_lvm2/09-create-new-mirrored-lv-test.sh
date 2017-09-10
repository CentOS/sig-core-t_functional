#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - Create new Volume Group and Mirrored Logical volume tests"


disk3=`losetup -a | grep t_lvm_temp_dir/disk3.img | cut -d: -f1`
disk4=`losetup -a | grep t_lvm_temp_dir/disk4.img | cut -d: -f1`

pvcreate $disk3 && \
pvcreate $disk4 && \
vgcreate vg_t_lvm_mirror $disk3 $disk4 &&\
lvcreate -m1 -L 300m -n lv_mirror_test vg_t_lvm_mirror 
mkfs.ext4 /dev/vg_t_lvm_mirror/lv_mirror_test &&\
mkdir /mnt/t_lvm_mirror &&\
mount /dev/vg_t_lvm_mirror/lv_mirror_test /mnt/t_lvm_mirror &&\
touch /mnt/t_lvm_mirror/test &&\
umount /mnt/t_lvm_mirror


t_CheckExitStatus $?
