#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org> 

t_Log "Running $0 - Remove LV/VG/PV tests"


disk0=`losetup -a | grep t_lvm_temp_dir/disk0.img | cut -d: -f1`
disk1=`losetup -a | grep t_lvm_temp_dir/disk1.img | cut -d: -f1`
disk2=`losetup -a | grep t_lvm_temp_dir/disk2.img | cut -d: -f1`
disk3=`losetup -a | grep t_lvm_temp_dir/disk3.img | cut -d: -f1`
disk4=`losetup -a | grep t_lvm_temp_dir/disk4.img | cut -d: -f1`
all_disks="$disk0 $disk1 $disk2 $disk3 $disk4"

lvremove -f /dev/vg_t_lvm/lv_t_lvm_test && \
lvremove -f /dev/vg_t_lvm_mirror/lv_mirror_test && \
vgremove -f vg_t_lvm && \
vgremove -f vg_t_lvm_mirror && \
pvremove -fy $all_disks &&\
(for disk in $all_disks ; do losetup -d $disk ; done)


t_CheckExitStatus $?
