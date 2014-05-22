#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>


t_Log "Running $0 - Update /etc/hosts"

echo "127.0.0.1 `hostname`" >> /etc/hosts

