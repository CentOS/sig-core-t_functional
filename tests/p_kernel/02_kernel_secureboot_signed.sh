#!/bin/bash
# This test will verify that grub2-efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that kernel is correctly signed with correct cert"

if [ "$centos_ver" = "7" ] ; then
  t_InstallPackage pesign 
  for kernel in $(rpm -q kernel --queryformat '%{version}-%{release}.%{arch}\n') 
    do
    t_log "Validating kernel $kernel ..."
    pesign --show-signature --in /boot/vmlinuz-${kernel}|grep -q 'Red Hat Inc.'
    t_CheckExitStatus $?
  done
else
  t_log "previous versions than CentOS 7 aren't using secureboot ... skipping"
  exit 0
fi

