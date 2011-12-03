#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - rsync function test."

# Comparing hostname with output of phpinfo()
FILE='/var/tmp/rsync-test'

cat > $FILE <<EOF
Testing rsync
EOF

php $FILE | grep -q 'Zend Engine'

t_CheckExitStatus $?

#reversing changes
/bin/rm $FILE
sed  -i 's/\date\.timezone\ \=\ \"Europe\/Berlin\"/\;date\.timezone\ \=/' /etc/php.ini
