#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test uniq command"

cat << EOF > /var/tmp/uniq-test
1
2
2
3
3
4
5
EOF

uniq -d /var/tmp/uniq-test | wc -l | grep -q 2 && uniq -u /var/tmp/uniq-test | wc -l | grep -q 3
t_CheckExitStatus $?
