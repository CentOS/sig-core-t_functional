#!/bin/bash
# Author:	???
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - checking if file can recognize symlink mime file type "

TEST_FILE_PATH="/tmp/p_file_link_test"

ln -s /etc/hosts $TEST_FILE_PATH

if (t_GetPkgRel basesystem | grep -q el5)
  then
  file -i $TEST_FILE_PATH | grep -q 'x-not-regular-file'
  ret_val=$?
else
  file -i $TEST_FILE_PATH | grep -q 'application/x-symlink'
  ret_val=$?
fi

t_CheckExitStatus $ret_val
