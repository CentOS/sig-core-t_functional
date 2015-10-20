#!/bin/bash

t_Log "Running $0 -  Verifying that kmod-ixbe installs and loads"

if [ "$centos_ver" = "7" ] ; then
  t_InstallPackage kmod-ixgbe
  modprobe ixgbe
  lsmod | grep -q 'ixgbe'
  t_CheckExitStatus $?
else
  t_log "previous versions than CentOS 7 aren't using kmod-ixgbe ... skipping"
  exit 0
fi

