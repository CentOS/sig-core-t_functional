#!/bin/sh
# Author: Nikhil Lanjewar <nikhil@lanjewar.com>
# Author: Sahil Muthoo <sahilm@thoughtworks.com>
# Author: Sahil Aggarwal <sahilagg@gmail.com>
# Author: Saager Mhatre <saager.mhatre@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - Check version of ruby ri."

#allready prepared just in case versions should change between C5 and C6
if [ "$centos_ver" -ge "8" ] ; then
  ri -v | grep -q '6.'
  ret_val=$?
elif [ "$centos_ver" = "7" ] ; then
  ri -v | grep -q '4.0'
  ret_val=$?
else
  ri -v | grep -q '1.0.1'
  ret_val=$?
fi

t_CheckExitStatus $ret_val

