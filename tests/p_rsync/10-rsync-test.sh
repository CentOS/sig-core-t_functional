#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - rsync function test."

FILE='/var/tmp/rsync-test'

cat > $FILE <<EOF
Testing rsync
EOF

#t_CheckExitStatus $?

#reversing changes
#/bin/rm $FILE
#sed  -i 's/\date\.timezone\ \=\ \"Europe\/Berlin\"/\;date\.timezone\ \=/' /etc/php.ini
