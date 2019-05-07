#!/bin/bash
# This test will verify that shim.efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that shim.efi is correctly signed with correct cert"

if [[ "$centos_ver" = "7" && "$arch" = "x86_64" ]] ; then
  [ -e /boot/efi/EFI/redhat/shim.efi ] && BOOT_EFI="/boot/efi/EFI/redhat/shim.efi"
  [ -e /boot/efi/EFI/centos/shim.efi ] && BOOT_EFI="/boot/efi/EFI/centos/shim.efi"
  if [ -z "$BOOT_EFI" ]; then 
      t_Log "WARNING: Cannot find proper shim.efi ! This host probably uses legacy boot :(."
      exit 0
  fi
  t_InstallPackage pesign shim
  pesign --show-signature --in /boot/efi/EFI/centos/shim.efi|grep -q 'Microsoft Windows UEFI Driver Publisher'
  t_CheckExitStatus $?
else
  t_Log "previous versions than CentOS 7 - or not x86_64 arch - aren't using shim/secureboot ... skipping"
  exit 0
fi

