#!/bin/bash
# Author: Neal Gompa <ngompa@datto.com>

# Skip if older than CentOS 8
if [ "$centos_ver" -lt "8" ]; then
  t_Log "annobin does not exist pre-c8 => SKIP"
  exit 0
fi

# Run the test
t_Log "Running $0 - build a hello world program with gcc using annobin"

BUILTPROG=$(mktemp)

cat <<EOF | gcc -x c -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -o ${BUILTPROG} -
#include <stdio.h>
int main() {
	printf("Hello World!\n");
	return 0;
}
EOF

${BUILTPROG} | grep -q "Hello World"
t_CheckExitStatus $?

rm -f ${BUILTPROG}
