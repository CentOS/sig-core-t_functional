#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - wget can access http-host and download index.html."
FILE=/var/tmp/index.html

if [ $SKIP_QA_HARNESS ]; then
  URL=http://wiki.centos.org/
  CHECK_FOR="FrontPage - CentOS Wiki"
else
  URL=http://repo.centos.qa/srv/CentOS/
  # athmane: could you please insert something here that is returned from qa-host
  CHECK_FOR="CentOS"
fi

t_Log "Querying http://${HOST}"
wget -q --output-document=${FILE} http://${URL}
grep -q "${CHECK_FOR}" ${FILE}
ret_val=$?

/bin/rm ${FILE}
t_CheckExitStatus $ret_val
