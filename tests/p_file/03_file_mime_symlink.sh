#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking if file can recognize symlink mime file type "

TEST_FILE_PATH=/tmp/p_file_link_test

ln -s /etc/hosts $TEST_FILE_PATH

case $centos_ver in
  5)
    mimetype='x-not-regular-file'
    ;;
  6)
    mimetype='application/x-symlink'
    ;;
  *)
    mimetype='inode/symlink'
    ;;
esac

file -i $TEST_FILE_PATH | grep -q $mimetype
ret_val=$?

t_CheckExitStatus $ret_val
