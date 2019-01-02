#!/bin/bash
# Author: Pratima Singh <prati.86@gmail.com>, Nilesh Bairagi <nileshbairagi@gmail.com>, Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - installing git"

# Install git
if [ $centos_ver -ge 6 ]
  then
  t_InstallPackage git
else
  t_Log "This test is skipped in CentOS5."
fi
