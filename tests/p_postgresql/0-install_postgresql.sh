#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at

t_Log "Running $0 - Installing postgresql server"

t_InstallPackage postgresql postgresql-server
