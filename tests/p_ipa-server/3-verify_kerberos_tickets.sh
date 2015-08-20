#!/bin/bash 
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)') && !(t_GetArch | grep -qE 'aarch64')
then

# kinit cannot take password from stdin so use expect

t_InstallPackage expect

t_Log "Running $0 - testing host kerberos principal"
klist -k /etc/krb5.keytab | grep "host/c6test.c6ipa.local" &> /dev/null

t_CheckExitStatus $?

t_Log "Running $0 - testing admin user kerberos principal"

kdestroy &> /dev/null

klist 2>&1  | grep -E "(No credentials|Credentials cache .* not found)" &> /dev/null

t_CheckExitStatus $?

expect -f - <<EOF
set send_human {.1 .3 1 .05 2}
spawn kinit admin
sleep 1
expect "Password for admin@C6IPA.LOCAL:"
send -h "p455w0rd\r"
sleep 5
close
EOF

klist | grep "admin@C6IPA.LOCAL" &> /dev/null

t_CheckExitStatus $?

else
    echo "Skipped on CentOS 5 and AArch64"
fi

