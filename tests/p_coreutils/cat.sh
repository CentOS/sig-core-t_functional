#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test cat command"

cat > /var/tmp/cat-test <<EOF
file 1
EOF
grep -q "file 1" /var/tmp/cat-test

echo "file 2" > /var/tmp/cat-test2 && grep -q "file 2" /var/tmp/cat-test2 
t_CheckExitStatus $?

rm /var/tmp/cat-test
