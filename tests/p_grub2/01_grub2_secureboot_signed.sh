#!/bin/bash
# This test will verify that grub2-efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that grub2-efi is correctly signed with correct cert"

if [ "$centos_ver" = "7" ] ; then
  t_InstallPackage pesign grub2-efi
  pesign --show-signature --in /boot/efi/EFI/centos/grubx64.efi|grep -q 0x7f55a3434808
  t_CheckExitStatus 0
else
  t_log "previous versions than CentOS 7 aren't using secureboot ... skipping"
  exit 0
fi

