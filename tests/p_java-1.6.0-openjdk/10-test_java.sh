#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

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
