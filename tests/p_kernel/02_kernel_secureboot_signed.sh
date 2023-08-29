#!/bin/bash
# This test will verify that grub2-efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that kernel is correctly signed with correct cert"

if [[ "$centos_ver" -ge 7 && "$arch" = "x86_64" ]] ; then
  t_InstallPackage pesign 
  for kernel in $(rpm -q kernel --queryformat '%{version}-%{release}.%{arch}\n') 
    do
    t_Log "Validating kernel $kernel ..."
    if [[ "$centos_ver" -eq 8 ]] ; then
      key_ver="201"
    elif [[ "$centos_ver" -eq 9 ]] ; then
      key_ver="201"
    fi 
    if [[ $is_almalinux == "yes" ]]; then
      key="AlmaLinux OS Foundation"
    else
      key="Red Hat Inc.|CentOS Secure Boot Signing $key_ver"
    fi
    if [[ "$centos_ver" -ge 8 && "$kernel" > "4.18.0-480.el8" ]] ; then
      pesign --show-signature --in /boot/vmlinuz-${kernel}|egrep -q "$key"
    else 
      pesign --show-signature --in /boot/vmlinuz-${kernel}|egrep -q "$key"
    fi
    t_CheckExitStatus $?
  done
else
  t_Log "previous versions than CentOS 7 - or not x86_64 -aren't using secureboot ... skipping"
  exit 0
fi

