#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - tar create and extract archive test."

# create dir and two files
TARDIR='/var/tmp/tar-test'
FILE1=$TARDIR/file1.txt
FILE2=$TARDIR/file2.txt

mkdir -p $TARDIR
cat > $FILE1 <<EOF
file #1
EOF

cat > $FILE2 <<EOF
file #2
EOF

# creating archive, remove source-dir
tar -c $TARDIR -f /var/tmp/tarfile.tar > /dev/null 2>&1
/bin/rm -rf $TARDIR
if [ -e $TARDIR ]
  then
  t_Log "something went wrong with deleting $TARDIR"
  exit
fi

#reextract from tar
tar -C / -xf /var/tmp/tarfile.tar
#checking file contents
grep -q 'file #1' $FILE1
RESULT1=$?
grep -q 'file #2' $FILE2
RESULT2=$?

if ([ $RESULT1 == 0 ] && [ $RESULT2 == 0 ])
  then 
  ret_val=0
fi

t_CheckExitStatus $ret_val

#reversing changes
/bin/rm -rf /var/tmp/tarfile.tar $TARDIR
