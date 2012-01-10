#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjodj <athmanem@gmail.com>

t_Log "Running $0 - python can print Hello World"

# creating source file
FILE='/var/tmp/python-test.py'

cat > $FILE <<EOF
print "hello centos"
EOF

# Executing python
python $FILE | grep -q "hello centos"

t_CheckExitStatus $?

# remove files
/bin/rm $FILE
