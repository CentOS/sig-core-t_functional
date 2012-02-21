#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - run a file through gzip,zcat and gunzip test."

# create file
FILE=/var/tmp/gzip-test.txt

cat > $FILE <<EOF
gzip-test of single file
EOF

# run file through gzip
gzip $FILE
#just to make shure
/bin/rm -rf $FILE

#run file through zcat
zcat $FILE.gz | grep -q 'gzip-test of single file'
if [ $? == 1 ]
  then
  t_Log 'zcat failed'
  exit
fi


#run file through gunzip
gunzip $FILE.gz

#checking file contents
grep -q 'gzip-test of single file' $FILE

t_CheckExitStatus $?

#reversing changes
/bin/rm -rf $FILE*
