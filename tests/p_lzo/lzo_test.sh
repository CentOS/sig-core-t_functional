#!/bin/sh
# Author: Vivek Dubey <dvivek@thoughtworks.com>
# Akshay Karle <akshayka@thoughtworks.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing lzo compression and decompression"

if [ $centos_ver = 5 ]
  then
  t_Log "This is a C5 system. Skipping."
  ret_val=0
else
  FILE1=/tmp/testfile.txt
  FILE2=/tmp/testfile.lzo

  echo 'CentOS' > ${FILE1}

  # running compression
  lzop -9 ${FILE1} -o ${FILE2}
  /bin/rm ${FILE1}

  lzop -d ${FILE2} -o ${FILE1}
  /bin/rm ${FILE2}

  #checking file content
  grep -q 'CentOS' ${FILE1}
  ret_val=$?

  #clean up
  /bin/rm ${FILE1}
fi

t_CheckExitStatus $ret_val
