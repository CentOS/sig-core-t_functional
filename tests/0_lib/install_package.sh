#!/bin/bash

function t_InstallPackage(){

  for P in $*; do
  	echo -n "[+] Attempting yum install of '$P'..."
	
	  $YUM -y -d0 install $P &>/dev/null
	  RETVAL=$?
	  if [ $RETVAL -ne 0 ]; then
		  echo "FAIL: yum install of '$P' failed ($RETVAL)"
		  exit $FAIL
	  fi
	  echo "OK"
  done
}
