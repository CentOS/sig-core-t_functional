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

t_Log "Running $0 - test adding sudo command"
ipa sudorule-add test_rule --desc="Test rule in ipa testing" --hostcat=all --cmdcat=all --runasusercat=all --runasgroupcat=all &> /dev/null
t_CheckExitStatus $?
ipa sudorule-add-user test_rule --users="ipatestuser" &> /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - verifying  sudo command is in freeipa"
sudodetails="$(ipa sudorule-show test_rule)"
echo "$sudodetails" | grep 'Rule name: test_rule' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'Description: Test rule in ipa testing' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'Enabled: TRUE' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'Host category: all' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'Command category: all' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'RunAs User category: all' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'RunAs Group category: all' &> /dev/null
t_CheckExitStatus $?
echo "$sudodetails" | grep 'Users: ipatestuser' &> /dev/null
t_CheckExitStatus $?

t_Log "Running $0 - clearing the sssd cache"
/sbin/service sssd stop &> /dev/null
rm -rf /var/lib/sss/db/*
/sbin/service sssd start &> /dev/null
/sbin/service sssd status | grep 'running' &> /dev/null
t_CheckExitStatus $?

## Leaving a little time to settle as there seems to be a slight race condition to go right away
sleep 10

t_Log "Running $0 - test sudo works"
expect -f -  &> /tmp/sudotestoutput.ipa-test <<EOF
set send_human {.1 .3 1 .05 2}
set timeout 10
spawn \$env(SHELL)
match_max 100000
expect "root@c6test ~\]# "
send -- "su - ipatestuser\r"
expect "sh-4.1\$ "
send -- "sudo -l\r"
sleep 5
expect "password for ipatestuser: "
send -- "newp455w0rd\r"
sleep 2
expect  "ALL) ALL\r"
EOF

grep 'testuser may run the following commands' /tmp/sudotestoutput.ipa-test &> /dev/null
t_CheckExitStatus $?
grep 'ALL) ALL' /tmp/sudotestoutput.ipa-test &> /dev/null
t_CheckExitStatus $?

else
    echo "Skipped on CentOS 5 and AArch64" 
fi

