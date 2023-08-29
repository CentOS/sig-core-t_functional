#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>

# Check for centos.org in preferences.js

website="www.centos.org"

if [[ $is_almalinux == "yes" ]]; then
  if [[ $centos_ver == "8" ]]; then
    website="www.almalinux.org"
  elif [[ $centos_ver == "9" ]]; then
    website="http://almalinux.org/"
  fi
fi

t_Log "Running $0 - firefox has $website as default page."

if (t_GetArch firefox | grep -q 'x86_64')
  then
  path='/usr/lib64/firefox/defaults/preferences/all-redhat.js'
  else
  path='/usr/lib/firefox/defaults/preferences/all-redhat.js'
fi

count=$(grep -c $website $path)

if [ $count -eq 2 ]
  then
  t_CheckExitStatus 0
  else
  t_CheckExitStatus 1
fi
