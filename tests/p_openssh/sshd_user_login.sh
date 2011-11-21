#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

userdel -rf sshtest; useradd sshtest && echo sshtest | passwd --stdin sshtest

# Create a test file
touch /home/sshtest/ssh_test_file

t_Log "Running $0 - SSH user login test."

./tests/p_openssh/_helper_sshd_user_login.expect | grep "ssh_test_file"
 > /dev/null 2>&1

t_CheckExitStatus $?

userdel -rf sshtest

