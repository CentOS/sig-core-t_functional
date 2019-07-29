#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

if (t_GetPkgRel dovecot | egrep -q 'el6|7|8')
then
   t_Log "Running $0 - Configuration of Dovecot"

   cat > /etc/dovecot/conf.d/11-mail.conf <<EOF
mail_location = mbox:~/mail:INBOX=/var/mail/%u
mail_privileged_group = mail
EOF

t_ServiceControl dovecot restart

else
   t_Log "This script is not required for CentOS 5.x"
fi 
