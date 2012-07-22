#!/bin/sh
FILE=/tmp/test_lftp_ftp.txt

if [ $SKIP_QA_HARNESS ]; then
URL="ftp://ftp.freebsd.org/pub/FreeBSD/"
else
URL="ftp://ftp.freebsd.org/pub/FreeBSD/"
fi


lftp -e 'set net:timeout 10; get README.TXT -o $FILE; bye' $URL   > /dev/null 2>&1
t_Log "Running $0 - lftp test with FTP test."
if [ -f $FILE ]
  then
  grep -ci 'konark' $FILE
  ret_val=$?
  else
  t_Log "FTP test for lftp failed"
  ret_val=$?
fi
rm -f $FILE
t_CheckExitStatus $ret_val
