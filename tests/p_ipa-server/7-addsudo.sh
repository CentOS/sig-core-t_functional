#!/bin/bash
# Author: James Hogarth <james.hogarth@gmail.com>
#

if (t_GetPkgRel basesystem | grep -q el6)
then

# Need admin credentials
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



t_Log "Running $0 - test adding sudo command"
## add sudo command here to ipa

t_Log "Running $0 - test adding sudo configuration"
## configure sssd and nsswitch for sudo here

t_Log "Running $0 - test sudo works"
## do a sudo -l as a user here to verify it works


else
    echo "Skipped on CentOS 5"
fi

