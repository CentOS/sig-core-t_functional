#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - openssl create self signed certificate, build symlink and verify certificate test."

ret_val=0

# create working-dir
TESTDIR='/var/tmp/openssl-test'

mkdir -p $TESTDIR

#create private key
if (t_GetPkgRel basesystem | grep -q el6) 
  then
  openssl genpkey -algorithm rsa -out $TESTDIR/server.key.secure -pkeyopt rsa_keygen_bits:2048 > /dev/null 2>&1
else
  openssl genrsa -passout pass:centos -des3 -rand file1:file2:file3:file4:file5 -out $TESTDIR/server.key.secure 2048 > /dev/null 2>&1
fi
if [ $? == 1 ]
  then t_Log "Creation of private key failed."
  ret_val=1
  exit
fi

#create default answer file
cat > $TESTDIR/openssl_answers<<EOF
[ req ]
default_bits       = 2048
distinguished_name = req_distinguished_name
string_mask        = nombstr
[ req_distinguished_name ]
countryName                     = Country Name (2 letter code)
countryName_default             = UK
stateOrProvinceName             = State or Province Name (full name)
stateOrProvinceName_default     = somestate
localityName                    = Locality Name (eg, city)
localityName_default            = somecity
0.organizationName              = Organization Name (eg, company)
0.organizationName_default      = CentOS-Project
organizationalUnitName          = Organizational Unit Name (eg, section)
organizationalUnitName_default  = CentOS
EOF

if (t_GetPkgRel basesystem | grep -q el6) 
  then
  openssl rsa -in $TESTDIR/server.key.secure -out $TESTDIR/server.key > /dev/null 2>&1
else
  openssl rsa -passin pass:centos -in $TESTDIR/server.key.secure -out $TESTDIR/server.key > /dev/null 2>&1
fi
if [ $? == 1 ]
  then t_Log "Creation of server key failed."
  ret_val=1
  exit
fi

openssl req -batch -config $TESTDIR/openssl_answers -new -key $TESTDIR/server.key -out $TESTDIR/server.csr > /dev/null 2>&1
if [ $? == 1 ]
  then t_Log "Creation of CSR failed."
  ret_val=1
  exit
fi

openssl x509 -req -days 3600 -in $TESTDIR/server.csr -signkey $TESTDIR/server.key -out $TESTDIR/server.crt > /dev/null 2>&1
if [ $? == 1 ]
  then t_Log "Creation of CRT failed."
  ret_val=1
  exit
fi

# get openssl-Path
sslvar=$(openssl version -d)
regex='OPENSSLDIR\:\ \"(.*)\"'
if [[ $sslvar =~ $regex ]]
  then
  sslpath=${BASH_REMATCH[1]}
else
  t_Log "Could not find openssl config directory"
  ret_val=1
  exit
fi

# prepare verification of certificate
cp $TESTDIR/server.crt $sslpath/certs/
HASH=$(openssl x509 -noout -hash -in $sslpath/certs/server.crt)
if [ $? == 1 ]
  then t_Log "Creation of Certificate HASH failed."
  ret_val=1
  exit
fi

#Link Hash to Cert
ln -s $sslpath/certs/server.crt $sslpath/certs/${HASH}.0

#do verification
openssl verify /var/tmp/openssl-test/server.crt |grep -c -q OK
if [ $? == 1 ]
  then t_Log "Self signed Cert verification failed."       
  ret_val=1
  exit
fi
t_CheckExitStatus $ret_val

#reversing changes
/bin/rm -rf $TESTDIR $sslpath/certs/server.crt $sslpath/certs/${HASH}*
