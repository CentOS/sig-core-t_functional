#!/bin/bash

# Author: Pratima Singh <prati.86@gmail.com>, Nilesh Bairagi <nileshbairagi@gmail.com>, Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

# Tsting git log and git commit msgs
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
t_CheckExitStatus $?
