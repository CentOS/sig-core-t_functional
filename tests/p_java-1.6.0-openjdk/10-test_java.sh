#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

if [ $centos_ver -ge 8 ]; then
  echo "Package not included in CentOS $centos_ver, skipping"
  exit 0
fi
if (t_GetArch | grep -qE 'aarch64|ppc64le')
  then
  echo "Package not included for current arch, skipping"
  exit 0
fi

t_Log "Running $0 - javac can compile and java can print 'hello centos'"

# selecting the right alternative
t_Select_Alternative java jre-1.6.0-openjdk
t_Select_Alternative javac java-1.6.0-openjdk

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
