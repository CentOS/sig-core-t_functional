#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - ruby can run 'hello world'"

# create ruby script
FILE=/var/tmp/test.rb
cat > $FILE <<EOF
#!/usr/bin/ruby
# Hello world ruby program
puts "hello world";
EOF

ruby $FILE | grep -q 'hello world'

t_CheckExitStatus $?

# and clean up
/bin/rm ${FILE}
