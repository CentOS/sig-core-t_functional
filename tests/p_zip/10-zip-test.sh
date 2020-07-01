#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - zip create and extract archive test."

# create dir and two files
ZIPDIR='/var/tmp/zip-test'
FILE1=$ZIPDIR/file1.txt
FILE2=$ZIPDIR/file2.txt

mkdir -p $ZIPDIR
cat > $FILE1 <<EOF
file 1
EOF

cat > $FILE2 <<EOF
file 2
EOF

# creating archive, remove source-dir
zip -q /var/tmp/testfile.zip $ZIPDIR/*
/bin/rm -rf $ZIPDIR
if [ -e $ZIPDIR ]
  then
  t_Log "something went wrong with deleting $ZIPDIR"
  exit
fi

#reextract from zip
unzip -q /var/tmp/testfile.zip -d /
#checking file contents
grep -q 'file 1' $FILE1
RESULT1=$?
grep -q 'file 2' $FILE2
RESULT2=$?

if ([ $RESULT1 == 0 ] && [ $RESULT2 == 0 ])
  then 
  ret_val=0
fi

t_CheckExitStatus $ret_val

#reversing changes
/bin/rm -rf /var/tmp/testfile.zip $ZIPDIR
