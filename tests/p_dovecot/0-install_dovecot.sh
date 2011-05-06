#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Dovecot 
yum -y install dovecot
chkconfig dovecot on
service dovecot start
