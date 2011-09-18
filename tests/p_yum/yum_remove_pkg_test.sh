#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - yum remove package test."

# Install zsh pkg
t_InstallPackage zsh

yum -d0 -y remove zsh && \
rpm -q zsh | grep -q 'package zsh is not installed'

t_CheckExitStatus $?
