#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test tail command"

cat << EOF > /var/tmp/tail-test
1
2
3
4
5
EOF

tail -n1 /var/tmp/tail-test | grep -q 5
t_CheckExitStatus $?

# Cleanup
rm /var/tmp/tail-test
