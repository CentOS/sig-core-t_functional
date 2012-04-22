#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "$0 - installing amanda system"
t_InstallPackage amanda amanda-server amanda-client
