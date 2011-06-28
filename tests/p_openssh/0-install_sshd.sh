#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# expect is needed by the test
t_InstallPackage openssh-server openssh-clients expect
chkconfig sshd on
t_ServiceControl sshd start
