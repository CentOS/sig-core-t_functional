#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)') && !(t_GetArch | grep -qE 'aarch64')
then

# Need admin credentials
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


t_Log "Running $0 - Adding test service"
ipa service-add	testservice/c6test.c6ipa.local &> /dev/null

t_CheckExitStatus $?

t_Log "Running $0 - getting keytab for service"
ipa-getkeytab -s c6test.c6ipa.local -p testservice/c6test.c6ipa.local -k /tmp/testservice.keytab &> /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - getting certificate for service"
ipa-getcert request -K testservice/c6test.c6ipa.local -D c6test.c6ipa.local -f /etc/pki/tls/certs/testservice.crt -k /etc/pki/tls/private/testservice.key &> /dev/null
t_CheckExitStatus $?

while true
do
entry="$(ipa-getcert list -r | sed -n '/Request ID/,/auto-renew: yes/p')"
if [[ $entry =~ "status:" ]] && [[ $entry =~ "CA_REJECTED" ]]
then
t_CheckExitStatus 1
break
fi
if [[ $entry =~ "" ]] 
then 
t_CheckExitStatus 0
break
fi
sleep 1
done

#avoiding race condition of certmonger getting the certificates and writing them but not actually on disk yet
while ! stat /etc/pki/tls/certs/testservice.crt &> /dev/null
do
sync
sleep 1
done

t_Log "Running $0 - verifying keytab"
klist -k /tmp/testservice.keytab | grep "testservice/c6test.c6ipa.local" &> /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - verifying key matches certificate"
diff <(openssl x509 -in /etc/pki/tls/certs/testservice.crt -noout -modulus 2>&1 ) <(openssl rsa -in /etc/pki/tls/private/testservice.key -noout -modulus 2>&1 )
t_CheckExitStatus $?

t_Log "Running $0 - verifying certificate against CA"
openssl verify -CAfile /etc/ipa/ca.crt /etc/pki/tls/certs/testservice.crt | grep "/etc/pki/tls/certs/testservice.crt: OK" &> /dev/null
t_CheckExitStatus $?

else
    echo "Skipped on CentOS 5 and AArch64"
fi


