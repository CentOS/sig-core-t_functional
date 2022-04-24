#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>
# 	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - lftp: HTTP test"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

if [ $SKIP_QA_HARNESS -eq 1 ]; then
  URL="http://mirror.centos.org/"
else
  URL="http://repo.centos.qa/srv/CentOS/"
fi

CHECK_FOR="UTC"
FILE="timestamp.txt"

t_Log "Querying ${URL}${FILE}"

lftp <<EOF
pget -n 5 ${URL}${FILE}
bye
EOF

grep -q "${CHECK_FOR}" ${FILE}
t_CheckExitStatus $?

/bin/rm ${FILE}
