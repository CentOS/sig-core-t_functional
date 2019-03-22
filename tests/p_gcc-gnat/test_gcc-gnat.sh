#!/bin/sh
# Author: Pablo Greco <pablo@fliagreco.com.ar>

t_Log "Running $0 - gcc-gnat can build a hello.adb"

if [ "$centos_ver" -lt 7 ] ; then
  t_Log "CentOS $centos_ver -> SKIP"
  exit 0
fi

# creating source code
pushd '/var/tmp' >/dev/null
FILE='/var/tmp/gcctesthello.adb'
EXE='/var/tmp/gcctesthello'

cat > $FILE <<EOF
with Ada.Text_IO;

procedure GccTestHello is
begin
  Ada.Text_IO.Put_Line("hello, centos!");
end GccTestHello;
EOF

# Executing gcc
gnat make -o $EXE $FILE

# run EXE
$EXE |grep -q 'hello, centos'
t_CheckExitStatus $?

# remove files
/bin/rm $FILE $EXE $EXE.ali $EXE.o
popd >/dev/null
