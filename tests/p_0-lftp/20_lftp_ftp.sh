#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>
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
