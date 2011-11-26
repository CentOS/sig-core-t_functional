#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - rpm remove package test."

# Install zsh pkg
t_InstallPackage zsh

rpm -e zsh && \
rpm -q zsh | grep -q 'package zsh is not installed'

t_CheckExitStatus $?

t_Log "Clean yum metadata / cache"
yum -y clean all
