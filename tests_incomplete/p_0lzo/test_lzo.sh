#!/bin/sh
# Author: Vivek Dubey <dvivek@thoughtworks.com>
# Akshay Karle <akshayka@thoughtworks.com>

echo 'blahblahblah' > /tmp/foo

lzop -9v /tmp/foo -o /tmp/foo.lzo

lzop -d /tmp/foo.lzo -o /tmp/abc

rm -f /tmp/foo
rm -f /tmp/foo.lzo
rm -f /tmp/abc
t_CheckExitStatus $?
