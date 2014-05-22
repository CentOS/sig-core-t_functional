#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# nc (netcat) is required for the test

if [ "$centos_ver" = "7" ] ;then
  whois_pkg="whois"
else
  whois_pkg="jwhois"
fi

t_InstallPackage $whois_pkg nc

