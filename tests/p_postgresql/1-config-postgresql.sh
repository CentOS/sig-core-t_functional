#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel postgresql | grep -q el6)
then
   t_Log "Initialize PostgreSQL DB "     
   service postgresql initdb
   t_ServiceControl postgresql start
   sleep 15
else
   t_ServiceControl postgresql start
   sleep 15
fi 
