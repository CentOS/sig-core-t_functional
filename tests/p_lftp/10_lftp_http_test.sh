#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>
# 	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - lftp: HTTP test"

if [ $SKIP_QA_HARNESS -eq 1 ]; then
  CHECK_FOR="UTC"
  URL="http://mirror.centos.org/"
  FILE="timestamp.txt"
else
  CHECK_FOR="CentOS"
  ARCH=$(t_GetArch)
  if [ $ARCH == "i686" ]; then
    URL="http://repo.centos.qa/srv/CentOS/6/os/i386/"
  else
    URL="http://repo.centos.qa/srv/CentOS/6/os/x86_64/"
  fi
  FILE="RELEASE-NOTES-en-US.html"
fi

t_Log "Querying ${URL}${FILE}"

lftp <<EOF
pget -n 5 ${URL}${FILE}
bye
EOF

grep -q "${CHECK_FOR}" ${FILE}
t_CheckExitStatus $?

/bin/rm ${FILE}
