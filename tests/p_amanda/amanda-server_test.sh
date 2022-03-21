#!/bin/sh
# Author: Christoph Galuschka <tigalch@tigalch.org>
t_Log "Running $0 - amanda server runs a simple task (backing up /etc)"

if (t_GetPkgRel basesystem | grep -q el5)
then
  t_Log "This is a C5 system. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

if (t_GetPkgRel basesystem | grep -q el9)
then
  t_Log "This is a C9 system. Amanda not present. Skipping."
  t_CheckExitStatus 0
  exit $PASS
fi

ret_val=0

# Creating necessary directories
mkdir -p /etc/amanda/MyConfig
mkdir -p /amanda/vtapes/slot{1,2}
mkdir -p /amanda/holding
mkdir -p /amanda/state/{curinfo,log,index}

# creating testfile in /etc
# just some content to grep later
STRING='This string must be found'
echo $STRING > /etc/amandabackup-test

cat > /etc/amanda/MyConfig/amanda.conf <<EOF
org "MyConfig"
infofile "/amanda/state/curinfo"
logdir "/amanda/state/log"
indexdir "/amanda/state/index"
EOF

if [ $centos_ver == 5 ]
then
  echo 'dumpuser "amanda"' >> /etc/amanda/MyConfig/amanda.conf
else
  echo 'dumpuser "amandabackup"' >> /etc/amanda/MyConfig/amanda.conf
fi

cat >> /etc/amanda/MyConfig/amanda.conf <<EOF
tpchanger "chg-disk:/amanda/vtapes"
labelstr "MyData[0-9][0-9]"
EOF

if [ $centos_ver -gt 6 ]
then
  echo 'autolabel "MyData%%"' >> /etc/amanda/MyConfig/amanda.conf
else
  echo 'label_new_tapes "MyData%%"' >> /etc/amanda/MyConfig/amanda.conf   
fi

cat >> /etc/amanda/MyConfig/amanda.conf <<EOF
tapecycle 2
dumpcycle 3 days
amrecover_changer "changer"

tapetype TESTTAPE
define tapetype TESTTAPE {
  length 100 mbytes
  filemark 4 kbytes
}

define dumptype simple-gnutar-local {
    auth "local"
    compress none
    program "GNUTAR"
}

holdingdisk hd1 {
    directory "/amanda/holding"
    use 50 mbytes
    chunksize 1 mbyte
}
EOF

echo "localhost /etc simple-gnutar-local" > /etc/amanda/MyConfig/disklist
if (t_GetPkgRel basesystem | grep -q el5)
then
  chown -R amanda /etc/amanda/MyConfig
  chown -R amanda /amanda
else
  chown -R amandabackup /etc/amanda/MyConfig
  chown -R amandabackup /amanda
fi

## running amanda configuration check
if (t_GetPkgRel basesystem | grep -q el5)
then
  su amanda -c 'amcheck MyConfig' | grep -q '0 problems found'
else
  su amandabackup -c 'amcheck MyConfig' | grep -q '0 problems found'
fi
if [ $? = 1 ] 
then
  t_Log "amanda Configuration check failed."
  ret_val=1
else
  t_Log "amanda Configuration OK."
fi

## running backup of /etc
if (t_GetPkgRel basesystem | grep -q el5)
then
  su amanda -c 'amdump MyConfig'  
else
  su amandabackup -c 'amdump MyConfig'
fi

if [ $? -ne 0 ]
then
  t_Log "Backup job failed."
  ret_val=1
else
  t_Log "Backup job successfull."
fi

## checking data in backup
grep -q "${STRING}" $(find /amanda/vtapes/ -name 00001.localhost._etc.0)
if [ $? -ne 0 ]
then
  t_Log "Something is wrong with the backup - can't find content of /etc/amandabackup-test file."
  ret_val=1
else
  t_Log "Backup seems OK and contains content of /etc/amandabackup-test file."
fi

# cleaning up
/bin/rm -rf /amanda
/bin/rm -rf /etc/amanda/MyConfig
/bin/rm -rf /etc/amandabackup-test

t_CheckExitStatus $ret_val

