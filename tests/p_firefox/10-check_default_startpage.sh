#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

# Check for centos.org in preferences.js
t_Log "Running $0 - firefox has www.centos.org as default page."

if (t_GetArch firefox | grep -q 'x86_64')
  then
  path='/usr/lib64/firefox/defaults/preferences/all-redhat.js'
  else
  path='/usr/lib/firefox/defaults/preferences/all-redhat.js'
fi

count=$(grep -c www.centos.org $path)

if [ $count=2 ]
  then
  t_CheckExitStatus 0
  else
  t_CheckExitStatus 1
fi
