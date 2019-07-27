#!/bin/bash

if [ "$centos_ver" -eq "8" ]; then
  t_Log "python not installed by default on .el8. SKIP"
  exit 0
else
   python tests/0_common/000_centos_default_repos.py
fi

