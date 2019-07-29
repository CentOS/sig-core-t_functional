#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - installing vsFTPd for local lftp test."
t_InstallPackage vsftpd
if [ "$centos_ver" -ge 8 ] ; then
cp -fp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.tf_p_lftp
sed -i 's/anonymous_enable=NO/anonymous_enable=YES/g' /etc/vsftpd/vsftpd.conf
fi
t_ServiceControl vsftpd restart
if [ "$centos_ver" -ge 8 ] ; then
mv -f /etc/vsftpd/vsftpd.conf.tf_p_lftp /etc/vsftpd/vsftpd.conf
fi

# Destination File
TESTFILE=/tmp/t_functional-lftp-test.txt

# Source File on FTP server
SOURCE=/var/ftp/
FILE=lftp-test.txt
cat > $SOURCE$FILE << EOF
t_functional
EOF
URL="ftp://127.0.0.1/"

t_Log "Running $0 - lftp test with local FTP server."

lftp -e 'set net:timeout 10; get '${FILE}' -o '$TESTFILE' ; bye' $URL > /dev/null 2>&1
if [ -f $TESTFILE ]
  then
  grep -q 't_functional' $TESTFILE
  ret_val=$?
  else
  t_Log "FTP test for lftp failed"
  ret_val=$?
fi

# clean up
rm -f $TESTFILE
rm -f $SOURCE$FILE
t_ServiceControl vsftpd stop

t_CheckExitStatus $ret_val
