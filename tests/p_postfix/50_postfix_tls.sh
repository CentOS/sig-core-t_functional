#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - Postfix plain SASL test."
if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi
t_Log "Installing prerequisits"

t_InstallPackage openssl

#creating backups of changed files
cp -a /etc/postfix/main.cf /etc/postfix/main.cf_testing
if [ $centos_ver = 5 ]
  then
  cp -a /etc/dovecot.conf /etc/dovecot.conf_testing
else
  cp -a /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf_testing
fi

#creating certificates
TESTDIR='/var/tmp/openssl-test'
mkdir $TESTDIR
t_Log "creating private key"
if [ $centos_ver = 6 ] 
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

t_Log "creating server key"
if [ $centos_ver = 6 ]
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

t_Log "creating server certificate"
openssl x509 -req -days 3600 -in $TESTDIR/server.csr -signkey $TESTDIR/server.key -out $TESTDIR/server.crt > /dev/null 2>&1
if [ $? == 1 ]
  then t_Log "Creation of CRT failed."
  ret_val=1
  exit
fi

#copy files to destinations
cp -a $TESTDIR/server.crt /etc/pki/tls/certs/
cp -a $TESTDIR/server.key /etc/pki/tls/private/

#adding parameters to postfix
cat >> /etc/postfix/main.cf <<EOF
smtpd_sasl_auth_enable = yes
broken_sasl_auth_clients = yes
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_security_options = noanonymous

smtpd_tls_security_level = may
smtpd_tls_key_file = /etc/pki/tls/private/mail.example.com.key
smtpd_tls_cert_file = /etc/pki/tls/certs/mail.example.com.cert
# smtpd_tls_CAfile = /etc/pki/tls/root.crt
smtpd_tls_loglevel = 1
smtpd_tls_session_cache_timeout = 3600s
smtpd_tls_session_cache_database = btree:/var/spool/postfix/smtpd_tls_cache
tls_random_source = dev:/dev/urandom
smtpd_tls_auth_only = yes

smtpd_recipient_restrictions =
      permit_mynetworks,
      permit_sasl_authenticated,
      reject_unauth_destination
EOF

#adding parameters to dovecot
if [ $centos_ver = 5 ]
  then
  cat > /etc/dovecot.conf <<EOF
protocol imap {
}
protocol pop3 {
}
protocol lda {
  postmaster_address = postmaster@example.com
}
auth default {
  mechanisms = plain
  passdb pam {
  }
  userdb passwd {
  }
  user = root
  socket listen {
    client {
      path = /var/spool/postfix/private/auth
      mode = 0660
      user = postfix
      group = postfix
    }
  }
}
dict {
}
plugin {
}
EOF
else
  cat >> /etc/dovecot/dovecot.conf <<EOF
service auth {
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
}
EOF
fi

#restarting services
t_ServiceControl postfix restart
t_ServiceControl dovecot restart

#Running test
t_Log "Testing if postfix accepts connections and offers STARTTLS"
echo "ehlo test" | nc -w 3 127.0.0.1 25 | grep -q 'STARTTLS'
ret_val=$?

# restoring changed files
mv -f /etc/postfix/main.cf_testing /etc/postfix/main.cf
if [ $centos_ver = 5 ]
  then
  mv -f /etc/dovecot.conf_testing /etc/dovecot.conf
else
  mv -f /etc/dovecot/dovecot.conf_testing /etc/dovecot/dovecot.conf
fi
rm -rf $TESTDIR/server.*
rm -rf /etc/pki/tls/certs/server.crt         
rm -rf /etc/pki/tls/private/server.key

t_CheckExitStatus $ret_val
