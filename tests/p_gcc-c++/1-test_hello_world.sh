#!/bin/bash
# Author: Dries Verachtert <dries.verachtert@dries.eu>

t_Log "Running $0 - test gcc-c++ with a hello world program"

CPPBINARY=`mktemp`

cat <<EOF | g++ -x c++ -o $CPPBINARY -
#include <iostream>
int main(int argc, char** argv) {
	std::cout << "Hello world!" << std::endl;
}
EOF

$CPPBINARY | grep -q "Hello world"
t_CheckExitStatus $?

rm -f $CPPBINARY
