#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

uname_arch=$(uname -m)

if [ "$uname_arch" == "armv7l" ]; then
  t_Log "*** Not testing on Arch: $uname_arch ***"
  exit 0
fi 

if (t_GetArch | grep -qE 'aarch64|armv7hl|ppc64le')
  then
  echo "Package not included for current arch, skipping"
  exit 0
fi

t_Log "Running $0 - javac can compile and java can print 'hello centos'"

# creating source file
PATH2FILE='/var/tmp/'
FILE='HelloWorld'
FILE2=$PATH2FILE$FILE.java

cat > $FILE2 <<EOF
public class HelloWorld {

  public static void main(String[] args) {
    System.out.println("hello centos");
  }
}
EOF

# Compiling
javac $FILE2
if [ $? == 1 ]
  then
  t_Log "Java-Compilation failed"
  exit
fi

# executing java
workpath=$(pwd)
cd $PATH2FILE
java $FILE |grep -q 'hello centos'

t_CheckExitStatus $?

cd $workpath
# remove files
/bin/rm $PATH2FILE$FILE.class $FILE2
