#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - run a file through bzip2,bzcat and bunzip2 test."

# create file
FILE=/var/tmp/bzip2-test.txt

cat > $FILE <<EOF
bzip2-test of single file
EOF

# run file through bzip2
bzip2 $FILE
#just to make sure
/bin/rm -rf $FILE

#run file through bzcat
bzcat $FILE.bz2 | grep -q 'bzip2-test of single file'
if [ $? == 1 ]
  then
  t_Log 'bzcat failed'
  exit
fi

#run file through bunzip2
bunzip2 $FILE.bz2

#checking file contents
grep -q 'bzip2-test of single file' $FILE

t_CheckExitStatus $?

#reversing changes
/bin/rm -rf $FILE*
