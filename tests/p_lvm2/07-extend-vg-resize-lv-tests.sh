#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - Extend Volume Group and resize Logical volume tests"


disk1=`losetup -a | grep t_lvm_temp_dir/disk1.img | cut -d: -f1`

pvcreate $disk1 &&\
vgextend vg_t_lvm $disk1 &&\
lvresize -L +600m /dev/vg_t_lvm/lv_t_lvm_test &&\
resize2fs /dev/vg_t_lvm/lv_t_lvm_test &&\
touch /mnt/t_lvm_test/test &&\
umount /mnt/t_lvm_test

t_CheckExitStatus $?
