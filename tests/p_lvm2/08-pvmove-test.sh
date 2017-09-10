#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - Move PEs from a PV to another test."


disk0=`losetup -a | grep t_lvm_temp_dir/disk0.img | cut -d: -f1`
disk2=`losetup -a | grep t_lvm_temp_dir/disk2.img | cut -d: -f1`

pvcreate $disk2 &&\
vgextend vg_t_lvm $disk2 &&\
pvmove $disk0 $disk2 &&\
mount /dev/vg_t_lvm/lv_t_lvm_test /mnt/t_lvm_test &&\
touch /mnt/t_lvm_test/test &&\
umount /mnt/t_lvm_test

t_CheckExitStatus $?
