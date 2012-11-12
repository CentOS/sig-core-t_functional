#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test head command"

cat << EOF > /var/tmp/head-test
1
2
3
4
5
EOF

head -n1 /var/tmp/head-test | grep -q 1
t_CheckExitStatus $?

# Cleanup
rm /var/tmp/head-test
