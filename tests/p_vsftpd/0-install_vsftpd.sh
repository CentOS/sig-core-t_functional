#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# vsFTPd
yum -y install vsftpd 
chkconfig vsftpd on
service vsftpd start

