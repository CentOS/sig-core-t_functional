#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - CentOS Anaconda patch is applied test."

ANACONDA_PATH=/usr/lib/anaconda/

(grep "id = \"centos\"" $ANACONDA_PATH/installclasses/rhel.py >/dev/null 2>&1) &&\

(grep "name = N_(\"CentOS Linux\")" $ANACONDA_PATH/installclasses/rhel.py >/dev/null 2>&1) &&\

(grep "\"CentOS\": (\"CentOS release\", )," $ANACONDA_PATH/installclasses/rhel.py >/dev/null 2>&1) 

t_CheckExitStatus $?
