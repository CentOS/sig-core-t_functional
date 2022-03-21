#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Rene Diepstraten <rene@renediepstraten.nl>

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi


# Install requirements
t_InstallPackage arpwatch psmisc net-tools

