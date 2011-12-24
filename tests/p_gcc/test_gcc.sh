#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjodj <athmanem@gmail.com>

t_Log "Running $0 - gcc can build a hello world .c"

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
$EXE |grep -cq 'hello, centos'
t_CheckExitStatus $?

# remove files
/bin/rm $FILE
/bin/rm $EXE


