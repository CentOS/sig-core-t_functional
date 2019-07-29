#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Note: This was a known issue in CentOS 6.0
# See: http://bugs.centos.org/view.php?id=4995

t_Log "Running $0 -  check that grub file layout is the same with upstream."

if [ "$centos_ver" -ge 7 ] ; then
  t_Log "el$centos_ver comes with grub2, skipping grub test ..."
  t_CheckExitStatus 0
  exit 0
fi


ARCH=`uname -m | sed 's/i6/i3/'`

[[ $( ls /usr/share/grub/ | wc -l ) -eq 1 ]] && \
ls /usr/share/grub/ | grep -q "$ARCH-redhat"

t_CheckExitStatus $?
