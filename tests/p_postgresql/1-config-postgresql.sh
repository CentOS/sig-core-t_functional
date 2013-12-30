#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - initializing and starting PostgreSQL"

t_Log "Initialize PostgreSQL DB "
if (t_GetPkgRel postgresql | grep -q el7) then
   postgresql-setup initdb
else if (t_GetPkgRel postgresql | grep -q el6) then
   service postgresql initdb
fi
fi

t_ServiceControl postgresql start
sleep 15


 
