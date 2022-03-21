#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install gzip."
t_InstallPackage gzip zip diffutils less util-linux-ng expect
if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "Ncompress unavailable in el9"
else
  t_InstallPackage ncompress 
fi

