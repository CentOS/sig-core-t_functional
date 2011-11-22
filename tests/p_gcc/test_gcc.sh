#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjodj <athmanem@gmail.com>

t_Log "Running $0 - simple gcc compilation test"

# creating source code
FILE='/var/tmp/gcc-test.c'
EXE='/var/tmp/gcc'

cat > $FILE <<EOF
#include <stdio.h>
main()
{
       printf("hello, centos\n");
}
EOF

# Executing gcc
gcc $FILE -o $EXE

# run EXE
WORKING=$( $EXE |grep -c 'hello, centos')

if [ $WORKING -eq 1 ]
then
  ret_val=0
else
  ret_val=1
fi

# remove files
/bin/rm $FILE
/bin/rm $EXE

t_CheckExitStatus $ret_val

