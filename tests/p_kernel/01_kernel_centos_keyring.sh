#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Note: This was a known issue with CentOS 6.0 GA kernel

t_Log "Running $0 -  check CentOS' Kernel Module GPG key."

uname_arch=$(uname -m)
uname_kernel=$(uname -r)
uname_kernel=${uname_kernel:0:6}


if [ "$uname_arch" == "aarch64" ] || [ "$uname_arch" == "armv7l" ] || [ "$uname_arch" == "i686" ]; then
  t_Log "*** Not testing on Arch: $uname_arch ***"
  exit 0
fi

if [ "$centos_ver" -ge 7 ] ; then
  if [ "$centos_ver" -eq 7 ];then
    if [ "$uname_arch" == "ppc64le" -a "$uname_kernel" == "4.18.0" ];then
      # power9 with c8 kernel
      ring=.builtin_trusted_keys
    else
      ring=.system_keyring
    fi
  else
    ring=.builtin_trusted_keys
  fi
  for id in kpatch "Driver update" kernel
  do
    t_Log "Verifying x.509 CentOS ${id}"
    keyctl list %:$ring | grep -i "CentOS Linux ${id} signing key" > /dev/null 2>&1
    t_CheckExitStatus $?
  done
else
  grep 'User ID: CentOS (Kernel Module GPG key)' /var/log/dmesg > /dev/null 2>&1
  t_CheckExitStatus $?
fi

