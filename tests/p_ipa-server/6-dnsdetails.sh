#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -qE 'el(6|7)')
then

# Need admin credentials
kdestroy &> /dev/null

klist 2>&1  | grep "No credentials" &> /dev/null

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

#Add zone
t_Log "Running $0 - Adding a subdomain 'testzone'"
ipa dnszone-add --name-server=c6test.c6ipa.local. --admin-email=hostmaster.testzone.c6ipa.local. testzone.c6ipa.local &> /dev/null
t_CheckExitStatus $?

#Can get SOA for new zone from DNS

#Add record to standard zone
t_Log "Running $0 - Adding a testrecord to main domain"
ipa dnsrecord-add c6ipa.local testrecord --cname-hostname=c6test &> /dev/null
t_CheckExitStatus $?

#Can get record from DNS
t_Log "Running $0 - Testing can retrieve record"
dig @localhost -t CNAME testrecord.c6ipa.local | grep "status: NOERROR" &> /dev/null
t_CheckExitStatus $?

#Add record to new zone
t_Log "Running $0 - Adding a testrecord to subdomain"
ipa dnsrecord-add testzone.c6ipa.local testrecord --cname-hostname=c6test.c6ipa.local. &> /dev/null
t_CheckExitStatus $?

#Can get record from DNS for new zone
t_Log "Running $0 - Testing can retrieve record from subdomain"
dig @localhost -t CNAME testrecord.testzone.c6ipa.local | grep "status: NOERROR" &> /dev/null
t_CheckExitStatus $?

#Configure global options instead of named.conf for forwarders - note this is looking for an ipv4 adddress ... there is no testing on ipv6 at this point
t_Log "Running $0 - Changing configuration to use LDAP for forwarder configuration"
forwarder="$(sed -n '1,/forwarders/!{ /};/,/forwarders/!s/^//p;}' /etc/named.conf |  sed 's/^[ \t]*\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\);$/\1/')"
sed -i '/forwarders/{N ; s/\n.*// }' /etc/named.conf
service named restart
t_CheckExitStatus $?
ipa dnsconfig-mod --forwarder=${forwarder} &> /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - Regression test of RHBA-2103-0739"
for i in {1..30}
do
service named reload &> /dev/null
service named status &> /dev/null || t_CheckExitStatus $?
sleep 1
done

t_CheckExitStatus $?

else
    echo "Skipped on CentOS 5"
fi

