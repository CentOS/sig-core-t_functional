#!/bin/bash
# Author: Pratima Singh <prati.86@gmail.com>, Nilesh Bairagi <nileshbairagi@gmail.com>, Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

# Check git installation

t_Log "Running $0 - checking git installation"

if [ $OS_VERSION -eq '6' ]
  then
  git --version
  ret_val=$?
else
  t_Log "This test is skipped in CentOS5."
  ret_val=0
fi
  
t_CheckExitStatus $ret_val
