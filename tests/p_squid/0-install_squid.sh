#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - installing Squid"
t_InstallPackage  squid
service squid start
