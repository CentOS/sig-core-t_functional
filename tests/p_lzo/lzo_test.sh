#!/bin/sh
# Author: Vivek Dubey <dvivek@thoughtworks.com>
# Akshay Karle <akshayka@thoughtworks.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing lzo compression and decompression"

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

t_CheckExitStatus $?
