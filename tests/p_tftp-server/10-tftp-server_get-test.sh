#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - tftp-server get file test."

if (t_GetPkgRel basesystem | grep -q el6)
then
  TFTP_DIR=/var/lib/tftpboot
else
  TFTP_DIR=/tftpboot
fi

chmod 777 $TFTP_DIR
echo "t_functional_test" > $TFTP_DIR/tftp_test
tftp  127.0.0.1 -c get tftp_test

cat tftp_test | grep -q 't_functional_test' 
ret_val=$?

/bin/rm -f tftp_test

t_CheckExitStatus $ret_val
