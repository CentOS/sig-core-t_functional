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



t_Log "Running $0 - test adding user"
userdetails="$(ipa user-add --first=test --last=user --random ipatestuser)"
echo "$userdetails" | grep 'Added user "ipatestuser"' &> /dev/null 

t_CheckExitStatus $?

t_Log "Running $0 - verify details of user"

echo "$userdetails" | grep ' First name: test' &> /dev/null 

t_CheckExitStatus $?

echo "$userdetails" | grep 'Last name: user' &> /dev/null 

t_CheckExitStatus $?

echo "$userdetails" | grep 'Full name: test user' &> /dev/null 

t_CheckExitStatus $?

echo "$userdetails" | grep 'Home directory: /home/ipatestuser' &> /dev/null 

t_CheckExitStatus $?

t_Log "Running $0 - testing initial password change of user"
kdestroy &> /dev/null

expect -f -  <<EOF
set send_human {.1 .3 1 .05 2}
spawn kinit ipatestuser
sleep 1
expect "Password for ipatestuser@C6IPA.LOCAL: "
send -h -- "$(echo "$userdetails" | awk '$0 ~ /Random password/ {print $3}')\r"
sleep 1
expect "Enter new password: "
send -h -- "newp455w0rd\r"
sleep 1
expect "Enter it again: "
send -h -- "newp455w0rd\r"
sleep 5
close
EOF

# Change in behaviour appears from C6.5 to C6.6 and kinit with expiry no longer results in kerberos ticket right away

expect -f - <<EOF
set send_human {.1 .3 1 .05 2}
spawn kinit ipatestuser
sleep 1
expect "Password for ipatestuser@C6IPA.LOCAL:"
send -h "newp455w0rd\r"
sleep 1
close
EOF


klist | grep "ipatestuser@C6IPA.LOCAL" &> /dev/null

t_CheckExitStatus $?

kdestroy &> /dev/null


t_Log "Running $0 - testing ipatestuser is in getent"
getent passwd ipatestuser &> /dev/null
t_CheckExitStatus $?

else
    echo "Skipped on CentOS 5 and AArch64"
fi


