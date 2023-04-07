#!/bin/bash
# This test will verify that grub2-efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that grub2-efi is correctly signed with correct cert"

arch=$(uname -m)

if [[ "$centos_ver" -ge 7 && "$arch" = "x86_64" ]] ; then
  t_InstallPackage pesign grub2-efi-x64
  pesign --show-signature --in /boot/efi/EFI/centos/grubx64.efi|egrep -q 'CentOS Secure Boot Signing 202'
  t_CheckExitStatus $?
else
  t_Log "previous versions than CentOS 7 - or not x86_64 arch - aren't using secureboot ... skipping"
  exit 0
fi

