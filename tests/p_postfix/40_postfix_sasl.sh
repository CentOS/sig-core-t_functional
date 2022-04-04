#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - Postfix plain SASL test."
if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi
t_Log "Installing prerequisits"

t_InstallPackage dovecot

#creating backups of changed files
cp -a /etc/postfix/main.cf /etc/postfix/main.cf_testing
if [ $centos_ver = 5 ]
  then
  cp -a /etc/dovecot.conf /etc/dovecot.conf_testing
else
  cp -a /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf_testing
fi

#adding parameters to postfix
cat >> /etc/postfix/main.cf <<EOF
smtpd_sasl_auth_enable = yes
broken_sasl_auth_clients = yes
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_security_options = noanonymous

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
t_Log "Testing if postfix accepts connections and offers AUTH PLAIN"
echo "ehlo test" | nc -w 3 127.0.0.1 25 | grep -q 'AUTH PLAIN'
ret_val=$?

# restoring changed files
mv -f /etc/postfix/main.cf_testing /etc/postfix/main.cf
if [ $centos_ver = 5 ]
  then
  mv -f /etc/dovecot.conf_testing /etc/dovecot.conf
else
  mv -f /etc/dovecot/dovecot.conf_testing /etc/dovecot/dovecot.conf
fi

t_CheckExitStatus $ret_val
