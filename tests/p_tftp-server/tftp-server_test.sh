#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - tftp-server get file test."

chmod 777 /var/lib/tftpboot
echo "t_functional_test" > /var/lib/tftpboot/tftp_test
tftp  127.0.0.1 -c get tftp_test

cat tftp_test | grep -q 't_functional_test' 
ret_val=$?

/bin/rm -f tftp_test

t_CheckExitStatus $ret_val
