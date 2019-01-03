#!/bin/bash
# Author: Pablo Greco <pablo@fliagreco.com.ar>
# Based on java-1.6.0-openjdk test from Christoph Galuschka <christoph.galuschka@chello.at>

. $(dirname "$0")/p_java-openjdk-common

for i in $JAVA_VERSIONS;do
t_Log "Running $0 - javac can compile and java can print 'hello centos'"

# selecting the right alternative
t_Select_Alternative java "(jre|java)-$i-openjdk"
t_Select_Alternative javac "java-$i-openjdk"

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
done
