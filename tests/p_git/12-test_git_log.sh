#!/bin/bash

# Author: Pratima Singh <prati.86@gmail.com>, Nilesh Bairagi <nileshbairagi@gmail.com>, Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>
# 	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing git logging and commit messages"

if [ $OS_VERSION -eq '6' ]
  then
  # Testing git log and git commit msgs
  workpath=$(pwd)
  rm -rf /tmp/temprepo/ /tmp/cloned_repo/ 
  temp_repo="/tmp/temprepo"
  mkdir -p $temp_repo
  cd $temp_repo
  git init . --bare
  cd /tmp
  git clone $temp_repo cloned_repo
  cd cloned_repo
  echo "hello world" > hello
  git add hello
  git commit -m "Temp commit" 2>&1
  git log --grep="Temp commit" 2>&1
  ret_val=$?
  cd $workpath
else
  t_Log "This test is skipped in CentOS5."
  ret_val=0
fi

t_CheckExitStatus $ret_val
