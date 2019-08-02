#!/bin/bash

# Author: Lz <Lz843723683@163.com>

if [ "$centos_ver" -ge "8" ];then
        t_Log "Package not included in CentOS $centos_ver => SKIP"
        exit 0
fi

t_Log "Running $0 - Testing make by running it with a basic file"

# creating source code
T_PATH='/var/tmp/make-test'
FILE="${T_PATH}/make-gcc.c"
EXE="${T_PATH}/make-gcc"
MAKEFILE="${T_PATH}/Makefile"


if [ ! -d "${T_PATH}" ];then
	mkdir -p ${T_PATH}
fi

cat > ${MAKEFILE} <<EOF
helloworld:
	gcc -o ${EXE} ${FILE}
EOF

cat > ${FILE} <<EOF
#include<stdio.h>
int main()
{
	printf("HelloWorld\n");
	return 0;
}
EOF


# Executing make
cd ${T_PATH}
make
cd -

# run EXE
$EXE | grep -q 'HelloWorld'
t_CheckExitStatus $?

# remove files
/bin/rm ${T_PATH} -rf
