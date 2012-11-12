#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 - test wc output"

cat << EOF > /var/tmp/wc-test
1 2
3 4
5 6
EOF

# file should have 3 lines, 12 bytes, 12 characters, max line length of 3, and 6 words
wc -l /var/tmp/wc-test | grep -q 3 && wc -c /var/tmp/wc-test | grep -q 12 && wc -m /var/tmp/wc-test | grep -q 12 && wc -L /var/tmp/wc-test | grep -q 3 && wc -w /var/tmp/wc-test | grep -q 6

t_CheckExitStatus $?

# Cleanup
rm /var/tmp/wc-test
