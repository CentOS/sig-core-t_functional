#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Postfix
t_InstallPackage postfix
t_RemovePackage sendmail
service postfix start

