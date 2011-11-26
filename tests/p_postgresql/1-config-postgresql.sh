#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel postgresql | grep -q el6)
then
   t_Log "Initialize PostgreSQL DB "     
   service postgresql initdb
   service postgresql restart
   sleep 5
else
   t_Log "This script is not required for CentOS 5.x"
fi 
