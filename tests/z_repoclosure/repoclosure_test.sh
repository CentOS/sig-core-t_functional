#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 -  repoclosure test ."

t_InstallPackage yum-utils

t_Log "Running repoclosure test ..."

repoclosure > /tmp/repoclosure.log 2>&1
deps_is=$(grep -c 'unresolved deps' /tmp/repoclosure.log)

# checking various distributions
if (( t_DistCheck | grep -q 6 ) && ( t_GetArch | grep -q x86_64 ))
  then
  unresdeps=5
fi
if (( t_DistCheck | grep -q 6 ) && ( t_GetArch | grep -q i386 ))
  then
  unresdeps=8
fi
if (( t_DistCheck | grep -q 5) && ( t_GetArch | grep x86_64 ))
  then
  # 5.8 seems to contain no unresolved deps
  unresdeps=0
fi
if (( t_DistCheck | grep -q 5) && ( t_GetArch | grep i386 ))
  then
  # 5.8 seems to contain no unresolved deps
  unresdeps=0
fi

if [ $deps_is -gt $unresdeps ] ; then
    ret_val=1
else
    ret_val=0
    t_Log 'repoclosure seems to deliver the number not more than the number of unresolved deps we expect'
fi

# print the output of repoclosure when it fails
[ $ret_val -eq 1 ] && cat /tmp/repoclosure.log

t_CheckExitStatus $ret_val
