#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>

t_Log "Running $0 - lftp: HTTP test"
if [ $SKIP_QA_HARNESS ]; then
CHECK_FOR="UTC"
URL="http://mirror.centos.org/centos//timestamp.txt"
else
CHECK_FOR="UTC"
URL="http://mirror.centos.org/centos//timestamp.txt"
fi

t_Log "Querying ${URL}"

lftp << EOF
pget -n 5 ${URL}
bye
EOF

grep -q "${CHECK_FOR}" timestamp.txt
ret_val=$?
rm timestamp.txt
t_CheckExitStatus $ret_val
