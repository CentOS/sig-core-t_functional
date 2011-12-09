#!/bin/sh
# Author:  Dan Trainor <dan.trainor@gmail.com>
#          Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - Check that we can get and set acl"

touch /tmp/acl_test_file

setfacl -m user:nobody:r-- /tmp/acl_test_file
getfacl  /tmp/acl_test_file |grep -q 'user:nobody:r--' 

t_CheckExitStatus $?

/bin/rm -f /tmp/acl_test_file
