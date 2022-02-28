#!/bin/bash

t_Log "Running $0 - installing python38-mod_wsgi"


if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. python38-mod-wsgi not present. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi


if [[ $centos_ver -lt 8 ]]; then
    t_Log "python38-mod_wsgi doesn't exist before CentOS 8 -> SKIP"
    exit 0
fi

# TODO: remove after 8.2 rebuild
if [[ $centos_stream == "no" ]]; then
    t_Log "python38-mod_wsgi is only in CentOS Stream -> SKIP"
    exit 0
fi

t_InstallPackage python38-mod_wsgi
