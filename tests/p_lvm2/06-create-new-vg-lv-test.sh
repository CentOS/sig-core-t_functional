#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - Create new Volume Group and Logical volume tests"


disk0=`losetup -a | grep t_lvm_temp_dir/disk0.img | cut -d: -f1`

pvcreate $disk0 && \
vgcreate vg_t_lvm $disk0 &&\
lvcreate -n lv_t_lvm_test -L 200m vg_t_lvm &&\
mkfs.ext4 /dev/vg_t_lvm/lv_t_lvm_test &&\
mkdir /mnt/t_lvm_test &&\
mount /dev/vg_t_lvm/lv_t_lvm_test /mnt/t_lvm_test &&\
touch /mnt/t_lvm_test/test 


t_CheckExitStatus $?
