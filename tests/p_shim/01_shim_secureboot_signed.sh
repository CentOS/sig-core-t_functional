#!/bin/bash
# This test will verify that shim.efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that shim.efi is correctly signed with correct cert"

if [[ "$centos_ver" = "7" && "$arch" = "x86_64" ]] ; then
  t_InstallPackage pesign shim
  pesign --show-signature --in /boot/efi/EFI/$vendor/shim.efi|grep -q 'Microsoft Windows UEFI Driver Publisher'
  t_CheckExitStatus $?
elif [[ "$centos_ver" -ge "8" && "$arch" = "x86_64" ]] ; then
  t_InstallPackage pesign shim
  pesign --show-signature --in /boot/efi/EFI/$vendor/shimx64.efi |grep -q 'Microsoft Windows UEFI Driver Publisher'
  t_CheckExitStatus $?
else
  t_Log "previous versions than CentOS 7 - or not x86_64 arch - aren't using shim/secureboot ... skipping"
  exit 0
fi

