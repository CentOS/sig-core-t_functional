#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - CentOS Anaconda patch is applied test."

if [ "$centos_ver" = "7" ];then
  ANACONDA_PATH=/usr/lib64/python2.7/site-packages/pyanaconda/
else
  ANACONDA_PATH=/usr/lib/anaconda/
fi

(grep "id = \"centos\"" $ANACONDA_PATH/installclasses/rhel.py >/dev/null 2>&1) &&\

(grep "name = N_(\"CentOS Linux\")" $ANACONDA_PATH/installclasses/rhel.py >/dev/null 2>&1) 


t_CheckExitStatus $?
