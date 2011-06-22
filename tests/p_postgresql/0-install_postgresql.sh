#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage postgresql postgresql-server
t_ServiceControl postgresql start
