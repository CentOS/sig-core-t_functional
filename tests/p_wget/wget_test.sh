#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - wget can access http-host and download index.html."
FILE=/var/tmp/index.html


if [ $SKIP_QA_HARNESS ]; then
  CHECK_FOR="CentOS"
  URL="http://wiki.centos.org/"
else
  CHECK_FOR="CentOS"
  URL="http://repo.centos.qa/srv/CentOS/"
fi

t_Log "Querying ${URL}"
wget -q --output-document=${FILE} ${URL}
grep -q "${CHECK_FOR}" ${FILE}
ret_val=$?

/bin/rm ${FILE}
t_CheckExitStatus $ret_val
