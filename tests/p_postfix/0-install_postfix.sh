#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Postfix
yum -y install postfix
yum -y remove sendmail
service postfix start

