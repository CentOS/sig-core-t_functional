#!/bin/bash

# Author: Pratima Singh <prati.86@gmail.com>, Nilesh Bairagi <nileshbairagi@gmail.com>, Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>

# Testing Git clone by comparing SHAs
rm -rf /tmp/temprepo/ /tmp/cloned_repo/ /tmp/testing_clone_repo  
temp_repo="/tmp/temprepo"
SHA1=`echo "hello world" | git hash-object --stdin`
mkdir -p $temp_repo
cd $temp_repo
git init . --bare
cd /tmp
git clone $temp_repo cloned_repo
cd cloned_repo
echo "hello world" > hello
git add hello
git commit -m "Temp commit"
git push origin master

git clone $temp_repo /tmp/testing_clone_repo
cd /tmp/testing_clone_repo
SHA2=`cat hello | git hash-object --stdin`
expr $SHA1 == $SHA2 2>&1
t_CheckExitStatus $?
