#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

# kinit cannot take password from stdin so use expect

t_InstallPackage expect

t_Log "Running $0 - testing host kerberos principal
klist -k /etc/krb5.keytab | grep "host/c6test.c6ipa.local" &> /dev/null

t_CheckExitStatus $?

t_Log "Running $0 - testing admin user kerberos principal

kdestroy &> /dev/null

klist 2>&1  | grep "No credentials" &> /dev/null

t_CheckExitStatus $?

expect -f - &> /dev/null <<EOF
set send_human {.1 .3 1 .05 2}
spawn kinit admin
sleep 1
expect "Password for admin@C6IPA.LOCAL:"
send -h "p455w0rd\r"
sleep 1
close
EOF

klist | grep "admin@C6IPA.LOCAL" &> /dev/null

t_CheckExitStatus $?


# MORE STUFF GOES HERE
