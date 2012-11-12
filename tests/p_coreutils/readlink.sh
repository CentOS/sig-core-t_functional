#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 checking readlink prints target of a symlink"

ln -s /var/tmp/foo /var/tmp/readlink-test
readlink /var/tmp/readlink-test | grep -q "/var/tmp/foo"
t_CheckExitStatus $?
rm /var/tmp/readlink-test
