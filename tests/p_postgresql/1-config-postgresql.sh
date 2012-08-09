#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - initializing and starting PostgreSQL"

if (t_GetPkgRel postgresql | grep -q el6)
then
   t_Log "Initialize PostgreSQL DB "     
   service postgresql initdb
   t_ServiceControl postgresql start
   sleep 15
else
   chmod 644 /etc/nsswitch.conf
   t_ServiceControl postgresql start
   sleep 15
fi 
