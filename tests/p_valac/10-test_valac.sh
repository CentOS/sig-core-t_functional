#!/bin/bash

# Author: Lz <Lz843723683@163.com>

#t_Log "Running $0 - Testing valac by running it with a basic file"

if [ "$centos_ver" -eq "8" ]; then
  t_Log "vala is not available in el8 => SKIP"
  exit 0
fi

# creating source code
FILE='/var/tmp/valac-test.vala'
EXE='/var/tmp/valac-test'

cat > $FILE <<EOF
class Demo.HelloWorld : GLib.Object {
public static int main(string[] args)
{
stdout.printf("HelloWorld!\n");
return 0;
}
}
EOF


# Executing valac
valac -o $EXE $FILE

# run EXE
$EXE | grep -q 'HelloWorld'
t_CheckExitStatus $?

# remove files
/bin/rm $FILE
/bin/rm $EXE
